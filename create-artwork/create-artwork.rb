Bundler.require

query = {
  access_token: ENV['ARTSY_ACCESS_TOKEN'] || raise('Missing ARTSY_ACCESS_TOKEN.'),
 }

# artwork

response = HTTParty.post('https://stagingapi.artsy.net/api/v1/artwork', query: query.merge(
  title: 'Test Artwork',
  artists: ['andy-warhol'],
  partner: '5b804902f31eeb0b2c1ff544',
))

raise "Error #{response.code.to_i}, #{response.body}" unless response.success?

artwork_id = response['id']
puts "Created https://stagingapi.artsy.net/api/v1/artwork/#{artwork_id}"

# image

response = HTTParty.post("https://stagingapi.artsy.net/api/v1/artwork/#{artwork_id}/image", query: query.merge(
  remote_image_url: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg'
))

raise "Error #{response.code.to_i}, #{response.body}" unless response.success?

image_id = response['id']
puts "Created https://stagingapi.artsy.net/api/v1/artwork/#{artwork_id}/image/#{image_id}"


