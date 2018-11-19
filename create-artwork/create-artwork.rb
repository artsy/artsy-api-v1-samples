Bundler.require

query = {
  access_token: ENV['ARTSY_ACCESS_TOKEN'] || raise('Missing ARTSY_ACCESS_TOKEN.'),
 }

response = HTTParty.post('https://stagingapi.artsy.net/api/v1/artwork', query: query.merge(
  title: 'Artwork 1',
  artists: ['andy-warhol'],
  partner: '5b804902f31eeb0b2c1ff544'
))

raise "Error #{response.code.to_i}, #{response.body}" unless response.success?

puts "Created https://stagingapi.artsy.net/api/v1/artwork/#{response['id']}"
