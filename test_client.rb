@client = SonyCiApi::Client.new('ci.yml')

@ws = [
  '051303c1c1d24da7988128e6d2f56aa9',  # Production workspace
  'f44132c2393d470c88b9884f45877ebb'   # Sandbox workspace
]


puts @client.workspace_search(@ws[0]).count
puts @client.workspace_search(@ws[1]).count
