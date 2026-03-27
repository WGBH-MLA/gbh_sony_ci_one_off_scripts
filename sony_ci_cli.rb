#!/usr/bin/env ruby

require 'bundler/setup'
require 'thor'
require 'sony_ci_api'
require_relative 'services/sony_ci/move_assets_from_list'

class SonyCiCli < Thor
  class_option :dry_run,
    type: :boolean,
    default: true,
    desc: "Print what would happen without moving assets"

  desc "move_from_list <file_list> <src_folder_id> <dest_folder_id>",
       "Move assets whose filenames appear in <file_list> (IDs only)"
  def move_from_list(file_list, src_folder_id, dest_folder_id)
    # Folder IDs are strings
    service = SonyCi::MoveAssetsFromList.new(
      client: client,
      dry_run: options[:dry_run]
    )

    service.call(
      file_list: file_list,
      src_folder_id: src_folder_id,
      dest_folder_id: dest_folder_id
    )

    puts "\nDone. #{options[:dry_run] ? 'Dry run only — no assets moved.' : 'Assets moved successfully.'}"
  end

  desc "list_folder <folder_id>", "Print the contents of a folder (ID only)"
  def list_folder(folder_id)
    contents = client.folder_contents(folder_id)
    puts "Contents of folder #{folder_id}:"
    contents.each do |item|
      puts "  [#{item['kind']}] #{item['name']} (ID: #{item['id']})"
    end
  end

  no_commands do
    def client
      @client ||= SonyCiApi::Client.new('./ci.yml')
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  begin
    SonyCiCli.start(ARGV)
  rescue StandardError => e
    warn "ERROR: #{e.message}"
    warn e.backtrace.join("\n") if ENV['DEBUG']
    exit 1
  end
end
