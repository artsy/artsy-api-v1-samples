#!/usr/bin/env bash

# Example artwork upload flow with curl

# 1. Find artist

curl -X GET https://api.artsy.net/api/v1/match/artists?term=picasso&size=5&page=1&exact=false&sort=name_exact \
     -H "x-access-token: ${access_token}"

# 2. First create the artwork with a POST

#    a. Works by a single artists, set the `artists` array param to single artist slug

curl -X POST https://api.artsy.net/api/v1/artwork \
     -H 'Content-Type: application/json' \
     -d "{ \"title\": \"Head\",
           \"artists\": [\"jean-michel-basquiat\"],
           \"access_token\": \"${access_token}\",
           \"partner_id\": \"${parter_id}\" }"

#    b. Works by multiple artists

curl -X POST https://api.artsy.net/api/v1/artwork \
     -H 'Content-Type: application/json' \
     -d "{ \"title\": \"Heart attack (in 2 parts)\",
           \"artists\": [\"andy-warhol\", \"jean-michel-basquiat\"],
           \"access_token\": \"${access_token}\",
           \"partner_id\": \"${parter_id}\" }"

# 3. Add images

curl -X POST https://api.artsy.net/api/v1/artwork/"${artwork_id}"/image
     -H 'Content-Type: application/json' \
     -d "{ \"remote_image_url\": \"https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg\"}"

# 4. Update metadata

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{\"additional_information\":\"Acquired from the collection and estate of Wolf Kahn and Emily Mason\\nA rare artists proof, #16 of 24 \\nPublished by Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany\\nCatalogue Raisonne: Axsom 250\",
          \"arta_enabled\":true,
          \"attribution_class\":\"limited edition\",
          \"blurb\":\"\",
          \"can_share_image\":true,
          \"category\":\"Print\",
          \"certificate_of_authenticity\":true,
          \"coa_by_authenticating_body\":null,
          \"coa_by_gallery\":true,
          \"collecting_institution\":\"\",
          \"condition_description\":\"very good condition\",
          \"confidential_notes\":\"\",
          \"depth\":\"\",
          \"ecommerce\":true,
          \"exhibition_history\":\"\",
          \"external_id\":null,
          \"featured_slot\":null,
          \"framed\":false,
          \"framed_depth\":\"\",
          \"framed_height\":\"\",
          \"framed_width\":\"\",
          \"framed_diameter\":null,
          \"framed_metric\":\"in\",
          \"height\":\"17.3\",
          \"image_rights\":\"\",
          \"import_source\":null,
          \"inventory_id\":\"\",
          \"literature\":\"Catalogue Raisonne: Axsom 250\",
          \"medium\":\"Lithograph and silkscreen on white Lana mould-made paper\",
          \"not_signed\":false,
          \"offer\":false,
          \"partner_location_id\":\"5748d22f139b21265b000352\",
          \"pickup_available\":true,
          \"price_currency\":\"USD\",
          \"price_includes_tax\":false,
          \"price_listed\":15000.0,
          \"price_max\":15000.0,
          \"price_min\":15000.0,
          \"provenance\":\"Acquired from the private collection and estate of Wolf Kahn and Emily Mason\",
          \"series\":\"\",
          \"shipping_weight\":\"\",
          \"shipping_weight_metric\":\"lb\",
          \"signature\":\"Signed, dated and annotated 'AP.16 F. Stella 97' in pencil\",
          \"signed_by_artist\":true,
          \"signed_in_plate\":false,
          \"signed_other\":false,
          \"stamped_by_artist_estate\":false,
          \"sticker_label\":false,
          \"title\":\"Prince of Hohenfliess (Axsom 250)\",
          \"width\":\"12.5\",
          \"artists\":[\"frank-stella\"],
          \"price_hidden\":\"false\",
          \"display_price_range\":\"false\",
          \"availability_hidden\":\"false\",
          \"availability\":\"for sale\",
          \"diameter\":null,
          \"duration\":null,
          \"metric\":\"in\",
          \"manufacturer\":null,
          \"publisher\":\" Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany.\",
          \"domestic_shipping_fee_cents\":\"\",
          \"international_shipping_fee_cents\":\"\"}"

# 5. Publish artwork (Can be combined with above request)

# NOTE: Requires title, artist_ids (artists), date, category, medium to be set on the artwork

# Eligible consts for category param:
     # "Painting"
     # "Sculpture"
     # "Photography"
     # "Print"
     # "Drawing, Collage or other Work on Paper"
     # "Mixed Media"
     # "Performance Art"
     # "Installation"
     # "Video/Film/Animation"
     # "Architecture"
     # "Fashion Design and Wearable Art"
     # "Jewelry"
     # "Design/Decorative Art"
     # "Textile Arts"
     # "Posters"
     # "Books and Portfolios"
     # "Other"
     # "Ephemera or Merchandise"
     # "Reproduction"

# Category will show up on staging.artsy.net under the Medium tag, we know it's confusing!
# A couple examples with different category and medium values:

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"published\": true,
           \"date\" : \"1984\",
           \"category\": \"Painting\",
           \"medium\": \"Acrylic on canvas\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"published\": true,
           \"date\" : \"2019\",
           \"category\": \"Photography\",
           \"medium\": \"C - type Fuji crystal archival print, Dibond mounted.\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"published\": true,
           \"date\" : \"2019\",
           \"category\": \"Sculpture\",
           \"medium\": \"Molded Foam & Acrylic, Paint\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"published\": true,
           \"date\" : \"2019\",
           \"category\": \"Mixed Media\",
           \"medium\": \"Plastic and wire on canvas\" }"

# 6. Check for published work from the JSON response, the slug is the id

# Example response:     { "_id": "61e70c74f852a9000c36c539",
#                         "id": "beth-reisman-test-title-3718936295",
#                         "title": "Test Title 3718936295",
#                         "display": "Beth Reisman, Test Title 3718936295 (1984)"
#                         .....
#                       }

https://www.artsy.net/artwork/"${id}"