require 'sony_ci_api'
require 'active_support/core_ext/time'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'

# unset the object so it gets completely overwritten below; for console testing.
Object.send(:remove_const, :MediaBoxMaker) if defined? MediaBoxMaker

class MediaBoxMaker
  attr_reader :guids, :params, :errors

  def initialize(guids, params={})
    @guids = Array(guids)
    @params = default_params.deep_merge(params.deep_stringify_keys)
    @params.delete('assetIds')
    @errors = []
  end

  def params_with_ids
    params.merge({ "assetIds" => sony_ci_ids })
  end

  def make!
    @response ||= client.post '/mediaboxes', params: params_with_ids
  rescue => e
    @errors << e
    nil
  end

  def make_again!
    @response = nil && make!
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

  def sony_ci_records
    @sony_ci_records ||= Array(guids).map do |guid|
      search_str = guid[-20..-1]
      begin
        client.workspace_search(query: search_str).first
      rescue => e
        @errors << e
        nil
      end
    end.compact
  end

  def sony_ci_ids
    sony_ci_records.map { |r| r['id'] }
  end
end


@guids_filename = 'guids_just_jazz_media_box.txt'

@guids = File.readlines(@guids_filename).map(&:chomp)


params = {
  "name" => "Media Box for Interns",
  "type" => "Protected",
  "allowSourceDownload" => true,
  "allowPreviewDownload" => false,
  "allowElementDownload" => false,
  "recipients" => [ "casey_davis-kaufman@wgbh.org" ],
  "message" => "Media Box for Interns",
  "password" => 'aapb051122',
  "expirationDays" => 180,
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

@mb = MediaBoxMaker.new(@guids, params)
