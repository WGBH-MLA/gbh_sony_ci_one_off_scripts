require 'sony_ci_api'
require 'active_support/core_ext/time'

# unset the object so it gets completely overwritten below; for console testing.
Object.send(:remove_const, :MediaBoxMaker) if defined? MediaBoxMaker

class MediaBoxMaker
  attr_reader :guids, :errors

  def initialize(guids)
    @guids = Array(guids)
    @errors = []
  end


  def request_body
    @request_body ||= default_request_body
    @request_body.merge(
      {
        "assetIds" => sony_ci_ids
      }
    )
  end

  def media_box_response
    @media_box_response = client.post '/mediaboxes', params: request_body
  rescue => e
    @errors << e
    nil
  end

  def default_request_body
    {
      "name" => "Peabody-Files-Brandeis-CLAMS-2",
      "type" => "Protected",
      "allowSourceDownload" => true,
      "allowPreviewDownload" => false,
      "allowElementDownload" => false,
      "recipients" => [ "andrew_myers@wgbh.org", "timothy_lepczyk@wgbh.org" ],
      "message" => "Peabody file from GBH for CLAMS project",
      "password" => 'clams_peabody',
      "expirationDays" => 105,
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


guids = File.readlines('Peabody_correctTrintTranscripts.txt').map(&:chomp)

small_sample_guids = guids[0..9]

@mb = MediaBoxMaker.new(small_sample_guids)
