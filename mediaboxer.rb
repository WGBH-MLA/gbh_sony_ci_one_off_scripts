require 'sony_ci_api'

# unset the object so it gets completely overwritten below; for console testing.
Object.send(:remove_const, :GUIDsToSonyCiIds) if defined? GUIDsToSonyCiIds


class GUIDsToSonyCiIds
  attr_reader :guids, :errors

  def initialize(guids)
    @guids = Array(guids)
    @errors = []
  end

  def client
    @client ||= SonyCiApi::Client.new('ci.yml')
  end

  def sony_ci_records
    @sony_ci_records ||= Array(guids).map do |guid|
      search_str = guid[-20..-1]
      client.workspace_search(query: search_str).first
    end
  end

  def sony_ci_ids
    sony_ci_records.map { |r| r['id'] }
  end
end

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
