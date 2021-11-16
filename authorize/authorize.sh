#!/usr/bin/env bash

# For testing/staging, change urls to stagingapi.artsy.net instead of api.artsy.net

# Option 1 (Recommended): Generate access token with redirect url

# 1. First direct your users to https://api.artsy.net/oauth2/authorize?client_id=${client_id}&redirect_uri=${your_website}&response_type=code
# 2. Extract the code from the query string after the redirect
# 3. 
curl -X POST https://api.artsy.net/oauth2/access_token \
     -H 'Content-Type: application/json' \
     -d "{ \"code\": \"${code}\", \"client_id\": \"${client_id}\", \"client_secret\": \"${client_secret}\", \"grant_type\": \"authorization_code\" }"

# Option 2: Generate access token for offline application

# Note: This is meant for applications that are not hosted online, and therefore do not have a redirect url.
#       For example, if your application runs locally on your client's desktop, this may be the only way for you to generate an access token if your desktop application does not support a web flow.
#       For all other applications, we do not recommend using this to generate a token, the first option is both more secure and seamless to the partner. 

curl -X POST https://api.artsy.net/oauth2/access_token \
     -H 'Content-Type: application/json' \
     -d "{ \"client_id\": \"${client_id}\", \"client_secret\": \"${client_secret}\", \"grant_type\": \"credentials\", \"email\": \"${partner_artsy_email}\", \"password\": \"${partner_artsy_password}\", \"scope\" : \"offline_access\" }"

