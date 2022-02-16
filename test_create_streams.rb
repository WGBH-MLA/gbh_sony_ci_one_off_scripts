require 'time'

@client = SonyCiApi::Client.new('ci.yml')
@client.workspace_id = "f44132c2393d470c88b9884f45877ebb"

@asset_id = "e0eb5dc99f1a45f4ac1abc54c87d4275"

@payload = {
  "streams": [
    {
      "name" => "test-stream-eleanor",
      "expirationDate" => (Time.now + 86400).iso8601,
      "videoSources" => [
        {
          "type" => "video-3g",
          "displayName" => "Video 3G"
        },
        {
          "type" => "video-sd",
          "displayName" => "Video SD"
        }
      ]
    }
  ]
}
