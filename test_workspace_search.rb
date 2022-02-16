require 'sony_ci_api'
require 'yaml'

@client = SonyCiApi::Client.new('./ci.yml')

@filenames = %w(
Barcode104849_P043107_ToServe_04
)

@sony_ci_ids = {}

@filenames.each do |filename|
  query = filename.split('_')[1]

  # THESE QUERIES RETURN ZERO RESULTS
  # query = filename
  # query = "+#{filename.gsub('_', ' ')}"
  # query = "+#{filename.gsub('_', ' +')}"
  # query = "#{filename}.mp4"
  search_result = @client.workspace_search(query: query)

  matching_items = search_result[:items].select { |item| item[:name] =~ /#{filename}/ }

  sony_ci_ids = matching_items.map { |item| item[:id] }

  puts "Found #{sony_ci_ids.count} matches for '#{query}'"

  @sony_ci_ids[filename] = if sony_ci_ids.empty?
    nil
  elsif sony_ci_ids.count == 1
    sony_ci_ids.first
  else
    sony_ci_ids
  end
end

puts "Fetching download links..."

@download_links = {}
@sony_ci_ids.each do |filename, sony_ci_id|
  link = @client.get(path: "assets/#{sony_ci_id}/download")[:location]
  puts "Download link for #{filename} is #{link.slice(0, 100)}"
  @download_links[filename] = link
end

require 'open-uri'
@download_links.each do |filename, link|
  dest = File.join('downloads', "#{filename}.mp4")
  puts "Downloading #{dest} from #{link.slice(0..100)}..."
  File.write(dest, open(link).read)
  puts "done."
end
