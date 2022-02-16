require 'sony_ci_api'
require 'yaml'
require 'open-uri'


class DownloadByFilename
  attr_reader :filenames
  def initialize(filenames: [])
    @filenames = filenames
  end

  def queries
    @queries ||= Hash[
      filenames.map do |filename|
        [filename, filename.slice(-20..-1)]
      end
    ]
  end

  def sony_ci_ids
    @search_results ||= Hash[
      queries.map do |filename, query|
        search_results = begin
          client.workspace_search(query: query)
        rescue
          # 404 ERRORS => not found => empty list of results
          puts "could not find result for filename #{filename}"
          []
        end

        # Filter only those that match the filename totally
        matched_item = search_results.detect { |item| item['name'] =~ /#{filename}/ }
        [filename, matched_item['id']]
      rescue => e
        [filename, "#{e.class} - #{e.message}"]
      end
    ]
  end

  def download_links
    @download_links ||= Hash[
      sony_ci_ids.map do |filename, sony_ci_id|

      end
    ]
    {}
    matching_items.each do |filename, matching_item|
      @download_links[filename] =
    end
  end

  def download!
    download_links.each do |filename, link|
      dest = File.join('downloads', "#{filename}.mp4")
      puts "Downloading #{dest} from #{link.slice(0..100)}..."
      File.write(dest, open(link).read)
      puts "done."
    end
  end

  private

    def client
      @client ||= SonyCiApi::Client.new('./ci.yml')
    end
end


# run the code!

@filenames = %w(
  Barcode104849_P043107_ToServe_04
)

@download_by_filename = DownloadByFilename.new(filenames: @filenames)

# download_by_filenames.download!
