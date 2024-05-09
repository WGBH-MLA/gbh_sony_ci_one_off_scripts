require 'sony_ci_api'
require 'active_support/core_ext/time'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'

# unset the object so it gets completely overwritten below; for console testing.
Object.send(:remove_const, :MediaBoxMaker) if defined? MediaBoxMaker

class MediaBoxMaker
  MAX_SIZE = 1000

  attr_reader :guids, :params, :errors, :responses

  def initialize(guids, params={})
    @guids = Array(guids).uniq
    @params = default_params.deep_merge(params.deep_stringify_keys)
    # assetIds param is constructed from GUID lookups, so ensure it's not part
    # of the passed in params.
    @params.delete('assetIds')
    @errors = []
  end

  # Makes one or more mediaboxes from the Sony Ci IDs retreived by looking up
  # the GUIDs in the Sony Ci API.
  # NOTE: When making large media boxes, we were getting "Asset Not Found" errors
  # even though all Assets exist. I think the assetIds param was getting cut off
  # due to large size, and resulting an a malformed ID, which was resulting in
  # the "Asset Not Found" error. As a workaround, we set a MAX_SIZE and create
  # however many mediaboxes we need, where none exceed MAX_SIZE. Currently, having
  # a MAX_SIZE of 1000 seems to work.
  def make!
    @responses ||= sony_ci_ids.each_slice(MAX_SIZE).map.with_index do |sony_ci_ids_slice, i|
      params_for_slice = params.merge({ "assetIds" => sony_ci_ids_slice })
      if sony_ci_ids.count > MAX_SIZE
        starts_at = i * MAX_SIZE + 1
        ends_at = i * MAX_SIZE + sony_ci_ids_slice.count
        slice_details = " (records #{starts_at}-#{ends_at} of #{sony_ci_ids.count})"
        params_for_slice['name'] += slice_details
        params_for_slice['message'] += slice_details
      end
      client.post '/mediaboxes', params: params_for_slice
    end
  rescue => e
    @errors << e
    nil
  end

  def default_params
    {
      "name" => "Test media box",
      "type" => "Protected",
      "allowSourceDownload" => true,
      "allowPreviewDownload" => false,
      "allowElementDownload" => false,
      "recipients" => [ "andrew_myers@wgbh.org" ],
      "message" => "Test Media Box",
      "password" => 'aapb',
      "expirationDays" => 1,
      "sendNotifications" => true,
      "notifyOnOpen" => true,
      "notifyOnChange" => true,
      "filters" => {
        "elements" => {
          "types" => [
            "Video"
          ]
        }
      }
    }
  end

  def client
    @client ||= SonyCiApi::Client.new('ci.yml')
  end

  # Returns a hash of Sony Ci search results keyed by GUID.
  # If the GUID search returned results, the value is the first result found.
  # If the GUID search returned no results, the value is nil.
  # If the GUID search errored, the value is nil and the error is added to
  #   @errors array.
  # Results can take a long time for long lists of GUIDs, to the result is
  #   memoized for subsequent calls.
  # Pass refresh: true to reset the memoized results and redo the search.
  def search_results(refresh: false)
    @search_results if refresh
    @search_results ||= {}.tap do |results|
      Array(guids).each do |guid|
        search_str = guid[-20..-1]
        search_result = begin
          client.workspace_search(query: search_str).first
        rescue => e
          @errors << e
          nil
        end
        results[guid] = search_result
      end
    end
  end

  def sony_ci_records
    # Any non-nil search result can expected to be single JSON Sony Ci result.
    search_results.values.compact
  end

  # Maps all Sony Ci records to their Sony Ci ID, which is used in the POST
  # request to make the media box.
  def sony_ci_ids
    sony_ci_records.map { |r| r['id'] }
  end

  def guids_not_found
    search_results.select { |guid, result| result.nil? }.keys
  end
end


@guids_filename = '../../data/mediabox_guids/All_WBGO_GUIDs_for_miranda.2023-12-08.txt'

@guids = File.readlines(@guids_filename).map(&:chomp)


@params = {
  "name" => "For Miranda - All WBGO videos",
  "type" => "Protected",
  "allowSourceDownload" => true,
  "allowPreviewDownload" => true,
  "allowElementDownload" => true,
  "recipients" => [ "miranda_villesvik@wgbh.org", "andrew_myers@wgbh.org" ],
  "message" => "ALL WBGO",
  "password" => 'winkbobblegoatoboe12',
  "expirationDays" => 365,
  "sendNotifications" => true,
  "notifyOnOpen" => false,
  "notifyOnChange" => true,
  "filters" => {
    "elements" => {
      "types" => [
        "Video"
      ]
    }
  }
}

@mb = MediaBoxMaker.new(@guids, @params)
# @mb.make!
