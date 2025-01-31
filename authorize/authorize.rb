require "faraday"
require "active_support/core_ext/object/to_query"

client_id = ENV['ARTSY_CLIENT_ID'] || raise('Missing ARTSY_CLIENT_ID.')
client_secret = ENV['ARTSY_CLIENT_SECRET'] || raise('Missing ARTSY_CLIENT_SECRET.')
redirect_uri = "https://localhost:5001/oauth/artsy"

auth_query = {
  client_id: client_id,
  redirect_uri: redirect_uri,
  response_type: 'code'
}

STDOUT.write "1. Navigate to https://stagingapi.artsy.net/oauth2/authorize?#{auth_query.to_query}\n"
STDOUT.write "2. Copy paste the code from the URL: "
code = gets.strip
puts "3. Using code #{code} ..."

token_query = {
  client_id: client_id,
  client_secret: client_secret,
  code: code,
  grant_type: 'authorization_code',
}

token_response = Faraday.get("https://stagingapi.artsy.net/oauth2/access_token?#{token_query.to_query}")
raise "Error #{token_response.code.to_i}, #{token_response.body}" unless token_response.success?

token_data = JSON.parse(token_response.body)
first_access_token = token_data['access_token']
first_expires_in = token_data['expires_in']

puts "access_token: #{first_access_token}"
puts "expires_in: #{first_expires_in}"

refresh_query = {
  client_id: client_id,
  client_secret: client_secret,
  code: first_access_token,
  grant_type: 'trust_token',
}

refresh_response = Faraday.get("https://stagingapi.artsy.net/oauth2/access_token?#{refresh_query.to_query}")
raise "Error #{refresh_response.code.to_i}, #{refresh_response.body}" unless refresh_response.success?

refresh_data = JSON.parse(refresh_response.body)
refreshed_access_token = refresh_data['access_token']
refreshed_expires_in = refresh_data['expires_in']

puts "access_token: #{refreshed_access_token}"
puts "expires_in: #{refreshed_expires_in}"
