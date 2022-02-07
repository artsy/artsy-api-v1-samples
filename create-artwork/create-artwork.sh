#!/usr/bin/env bash

# Example artwork upload flow with curl

# 1. Find artist

curl -X GET https://api.artsy.net/api/v1/match/artists?term=picasso&size=5&page=1&exact=false&sort=name_exact \
     -H "x-access-token: ${access_token}"

# 2. First create the artwork with a POST

#    NOTE: You won't be able to set the "published" field to true when first creating.
#          A follow up PUT request can be used to publish the artwork.

#    a. Works by a single artists, set the `artists` array param to single artist slug

curl -X POST https://api.artsy.net/api/v1/artwork \
     -H 'Content-Type: application/json' \
     -d "{ \"title\": \"Head\",
           \"artists\": [\"jean-michel-basquiat\"],
           \"access_token\": \"${access_token}\",
           \"partner\": \"${parter_id}\" }"

#    b. Works by multiple artists

curl -X POST https://api.artsy.net/api/v1/artwork \
     -H 'Content-Type: application/json' \
     -d "{ \"title\": \"Heart attack (in 2 parts)\",
           \"artists\": [\"andy-warhol\", \"jean-michel-basquiat\"],
           \"access_token\": \"${access_token}\",
           \"partner\": \"${parter_id}\" }"

# 3. Add images

#    a. Add via URL

curl -X POST https://api.artsy.net/api/v1/artwork/"${artwork_id}"/image
     -H 'Content-Type: application/json' \
     -d "{ \"remote_image_url\": \"https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg\"}"

#    b. Use Gemup to handle file upload

        See https://github.com/artsy/gemini/blob/7c327d67f92bd17121cde7f5b4fee2c5bb129b81/docs/uploading-to-gemini-with-gemup.md
             a. Reach out to your Artsy Engineering point of contact and have them create an Account in Gemini
             b. After they do that, they will give you a key in form of a string, most likely a name of your app
        See:
             https://github.com/artsy/gemini/blob/7c327d67f92bd17121cde7f5b4fee2c5bb129b81/docs/uploading-to-gemini-with-gemup.md

             https://github.com/artsy/gemup

        Also see https://github.com/artsy/gemup/blob/master/gemup.js for example in javascript

# 4. Update metadata

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{\"additional_information\":\"Acquired from the collection and estate of Wolf Kahn and Emily Mason\\nA rare artists proof, #16 of 24 \\nPublished by Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany\\nCatalogue Raisonne: Axsom 250\",
          \"arta_enabled\":true,
          \"artists\":[\"frank-stella\"],
          \"attribution_class\":\"limited edition\",
          \"availability\":\"for sale\",
          \"availability_hidden\":\"false\",
          \"blurb\":\"\",
          \"can_share_image\":true,
          \"category\":\"Print\",
          \"certificate_of_authenticity\":true,
          \"coa_by_authenticating_body\":null,
          \"coa_by_gallery\":true,
          \"collecting_institution\":\"\",
          \"condition_description\":\"very good condition\",
          \"confidential_notes\":\"\",
          \"date\":\"2009\",
          \"depth\":\"\",
          \"diameter\":null,
          \"display_price_range\":\"false\",
          \"domestic_shipping_fee_cents\":10000,
          \"duration\":null,
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
          \"international_shipping_fee_cents\":25000,
          \"inventory_id\":\"\",
          \"literature\":\"Catalogue Raisonne: Axsom 250\",
          \"location\":\"\",
          \"manufacturer\":null,
          \"medium\":\"Lithograph and silkscreen on white Lana mould-made paper\",
          \"metric\":\"in\",
          \"not_signed\":false,
          \"offer\":false,
          \"partner\":\"${partner_id}\",
          \"partner_location_id\":\"5748d22f139b21265b000352\",
          \"pickup_available\":true,
          \"price_currency\":\"USD\",
          \"price_hidden\":\"false\",
          \"price_includes_tax\":false,
          \"price_listed\":15000.0,
          \"price_max\":15000.0,
          \"price_min\":15000.0,
          \"provenance\":\"Acquired from the private collection and estate of Wolf Kahn and Emily Mason\",
          \"published\":false,
          \"publisher\":\" Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany.\",
          \"secondary_market\":true,
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
          \"unique\":true,
          \"width\":\"12.5\"}"

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
     -d "{ \"category\": \"Painting\",
           \"medium\": \"Acrylic on canvas\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"category\": \"Photography\",
           \"medium\": \"C - type Fuji crystal archival print, Dibond mounted.\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"category\": \"Sculpture\",
           \"medium\": \"Molded Foam & Acrylic, Paint\" }"

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"category\": \"Mixed Media\",
           \"medium\": \"Plastic and wire on canvas\" }"

# To publish:

curl -X PUT https://api.artsy.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{ \"published\": true }"

# 6. Check for published work from the JSON response, the slug is the id

# Example response:     { "_id": "61e70c74f852a9000c36c539",
#                         "id": "beth-reisman-test-title-3718936295",
#                         "title": "Test Title 3718936295",
#                         "display": "Beth Reisman, Test Title 3718936295 (1984)"
#                         .....
#                       }

https://www.artsy.net/artwork/"${id}"