Bundler.require

query = {
  client_id: ENV['ARTSY_CLIENT_ID'] || raise('Missing ARTSY_CLIENT_ID.'),
  redirect_uri: 'http://localhost',
  response_type: 'code'
}

STDOUT.write "1. Navigate to https://stagingapi.artsy.net/oauth2/authorize?#{query.to_query}\n"
STDOUT.write "2. Copy paste the code from the URL: "
code = gets.strip
puts "3. Using code #{code} ..."


query = {
  client_id: ENV['ARTSY_CLIENT_ID'] || raise('Missing ARTSY_CLIENT_ID.'),
  client_secret: ENV['ARTSY_CLIENT_SECRET'] || raise('Missing ARTSY_CLIENT_SECRET.'),
  grant_type: 'authorization_code',
  code: code
}

response = HTTParty.post('https://stagingapi.artsy.net/oauth2/access_token', query: query)
raise "Error #{response.code.to_i}, #{response.body}" unless response.success?

rc = JSON.parse(response.body)

puts "access_token: #{rc['access_token']}"
puts "expires_in: #{rc['expires_in']}"
