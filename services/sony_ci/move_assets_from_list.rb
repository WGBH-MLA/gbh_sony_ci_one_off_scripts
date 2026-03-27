# frozen_string_literal: true

require 'set'

module SonyCi
  class MoveAssetsFromList
    MEDIA_FILE_EXTENSIONS = ['.mp3', '.mp4', '.mov'].freeze

    attr_reader :client, :dry_run, :logger

    def initialize(client:, dry_run: true, logger: STDOUT)
      @client = client
      @dry_run = dry_run
      @logger = logger
    end

    # file_list: path to text file of filenames
    # src_folder_id: optional (used for filtering assets only)
    # dest_folder_id: ID of destination folder
    def call(file_list:, src_folder_id: nil, dest_folder_id:)
      filenames = load_filenames(file_list)
      raise ArgumentError, "Filename list is empty" if filenames.empty?

      # Fetch assets from either the source folder or entire workspace
      assets = fetch_assets(src_folder_id, filenames)

      report_results(assets, filenames, dest_folder_id)

      return assets if dry_run || assets.empty?

      move_assets!(assets, dest_folder_id)
      assets
    end

    private

    def load_filenames(path)
      Set.new(
        File.readlines(path, chomp: true)
            .map(&:strip)
            .reject(&:empty?)
      )
    end

    # Fetch all matching assets
    def fetch_assets(src_folder_id, filenames)
      all_assets =
        if src_folder_id
          fetch_assets_recursive(src_folder_id)
        else
          client.workspace_contents
        end

      all_assets.select do |item|
        item['kind']&.downcase == 'asset' &&
          filenames.include?(item['name']) &&
          item['name'].end_with?(*MEDIA_FILE_EXTENSIONS)
      end
    end

    def fetch_assets_recursive(folder_id, accumulator = [])
      contents = client.folder_contents(folder_id)

      contents.each do |item|
        case item['kind']&.downcase
        when 'asset'
          accumulator << item
        when 'folder'
          fetch_assets_recursive(item['id'], accumulator)
        end
      end

      accumulator
    end
    # -------- Reporting --------

    def report_results(assets, filenames, dest_folder_id)
      logger.puts "\nMatched #{assets.count} assets"

      missing = filenames - assets.map { |a| a['name'] }
      unless missing.empty?
        logger.puts "\nWARNING: Filenames not found:"
        missing.each { |name| logger.puts "  - #{name}" }
      end

      duplicates = assets.group_by { |a| a['name'] }.select { |_k, v| v.size > 1 }
      unless duplicates.empty?
        logger.puts "\nWARNING: Duplicate filenames detected:"
        duplicates.each { |name, group| logger.puts "  - #{name} (#{group.count} copies)" }
      end

      if dry_run
        logger.puts "\nDRY RUN — assets would be moved to folder ID \"#{dest_folder_id}\""
      else
        logger.puts "\nMoving assets to folder ID \"#{dest_folder_id}\""
      end
    end

    # -------- Move --------
def move_assets!(assets, dest_folder_id)
  asset_ids = assets.map { |a| a['id'] }
  workspace_id = "a1459cf719eb4a7cb2686663018be161"

  raise "Workspace ID could not be determined. Check ci.yml" unless workspace_id

  logger.puts "Preparing workspace-scoped move request..."
  logger.puts "  Workspace ID: #{workspace_id}"
  logger.puts "  Destination folder ID: #{dest_folder_id}"
  logger.puts "  Asset IDs: #{asset_ids.join(', ')}"

  payload = {
    assetIds: asset_ids,
    folderId: dest_folder_id
  }

  response = client.conn.post("/assets/move") do |req|
    req.headers['Authorization'] = "Bearer #{client.access_token}"
    req.headers['Content-Type'] = 'application/json'
    req.body = payload.to_json
  end

  logger.puts "Move successful! Status: #{response.status}"
  logger.puts "Response body: #{response.body}"
  response.body
rescue Faraday::ClientError => e
  if e.response
    status = e.response[:status]
    body   = e.response[:body]
    warn "ERROR: Move request failed with status #{status}"
    warn "Response body: #{body}"
    if body.is_a?(Hash) && body['message'] =~ /Unknown resource/
      warn "⚠️ Likely cause: asset ID or destination folder ID is invalid"
    end
  end
  raise e
end
end
end
