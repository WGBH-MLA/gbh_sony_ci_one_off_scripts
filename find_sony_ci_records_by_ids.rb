require 'sony_ci_api'

# Configure some params.
path_to_sony_ci_config_file = './ci.yml'
path_to_guids_list = './guids_have_transcripts_lookfor_sony.txt'
production_workspace_id = '051303c1c1d24da7988128e6d2f56aa9'

# Create the client for talking with Sony Ci api
client = SonyCiApi::Client.new(path_to_sony_ci_config_file)

# Set the active workspace to the AAPB production workspace.
client.workspace_id = production_workspace_id

# Get all the GUIDs from the guid list. Calling `chomp` on each entry nukes the
# newline char that File.readlines retains.
guids = File.readlines(path_to_guids_list).map(&:chomp)

# Map the guids to the Sony Ci IDs returned from doing a workspace search on
# each GUID.
sony_ci_ids = guids.map do |guid|

  # Workspace search only works if we limit our search to 20 chars, so grab the
  # last 20 chars of the GUID, as those are the most unique.
  guid_search_str = guid[-20..-1]

  # Setting `fields` option to nil will result in the default fields being
  # returned: 'id', 'name', 'kind'
  found_record = client.workspace_search(query: guid_search_str, fields: nil).first

  # return the Sony Ci ID if we found something; nil otherwise.
  found_record['id'] if found_record
end

puts sony_ci_ids
