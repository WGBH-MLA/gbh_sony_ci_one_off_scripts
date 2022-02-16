require 'sony_ci_api'

class GUIDsToSonyCiIds
  attr_reader :guids, :errors

  def initialize(guids)
    @guids = Array(guids)
    @errors = {}
  end

  def client
    @client ||= SonyCiApi::Client.new('ci.yml')
  end

  def guids_x_sony_ci_assets
    @guids_x_sony_ci_assets ||= Hash[
      Array(guids).map do |guid|
        search_str = guid[-20..-1]
        record = begin
          client.workspace_search(query: search_str).first
        rescue => e
          e.message += " (for GUID #{guid})"
          @errors << e
          nil
        end
        [guid, record]
      end
    ]
  end

  def guids_x_sony_ci_ids
    guids_x_sony_ci_assets.transform_values { |asset| asset['id'] }
  end

  def sony_ci_ids
    guids_x_sony_ci_ids.values
  end
end
