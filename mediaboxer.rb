require 'sony_ci_api'
require_relative 'guids_to_sony_ci_ids'

# unset the object so it gets completely overwritten below; for console testing.
Object.send(:remove_const, :GUIDsToSonyCiIds) if defined? GUIDsToSonyCiIds


@guids_file = "Peabody_correctTrintTranscripts.txt"
@sony_ci_ids_file = "#{@guids_file}.sony_ci_ids"
if !File.exists?(@sony_ci_ids_file)
  @guids = File.readlines(@guids_file, chomp: true)
  @guids_to_sony_ci_ids = GUIDsToSonyCiIds.new(@guids)
  File.write(@sony_ci_ids_file, @guids_to_sony_ci_ids.sony_ci_ids.join("\n"))
end

@sony_ci_ids = File.readlines(@sony_ci_ids_file, chomp: true)

@client = SonyCiApi::Client.new('ci.yml')

@mediabox_id = '3d3c83e7c3464dbca6761d52d7ed7c79'
@mediabox = @client.mediabox(@mediabox_id)

@sony_ci_ids.each_slice(50) do |sony_ci_ids|
  @client.mediabox_add_assets(@mediabox_id, sony_ci_ids)
rescue => e
  @error = e
  raise e
end
