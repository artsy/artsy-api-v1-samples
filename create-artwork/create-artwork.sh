#!/usr/bin/env bash

# Example artwork upload flow with curl

# 1. First create the artwork with a POST

curl -X POST https://api.arty.net/api/v1/artwork \
     -H 'Content-Type: application/json' \
     -d "{ \"title\": \"Test Title 3718936295\", \"artists\": \"['andy-warhol']\", \"access_token\": \"${access_token}\", \"partner_id\": \"${parter_id}\" }"

# 2. Add images

curl -X POST https://api.artsy.net/api/v1/artwork/"${artwork_id}"/image
     -H 'Content-Type: application/json' \
     -d "{ \"remote_image_url\": \"https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg\"}"

# 3. Update metadata

curl -X PUT https://api.arty.net/api/v1/artwork/"${artwork_id}" \
     -H 'Content-Type: application/json' \
     -d "{\"additional_information\":\"Acquired from the collection and estate of Wolf Kahn and Emily Mason\\nA rare artists proof, #16 of 24 \\nPublished by Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany\\nCatalogue Raisonne: Axsom 250\",\"arta_enabled\":true,\"attribution_class\":\"limited edition\",\"blurb\":\"\",\"can_share_image\":true,\"category\":\"Print\",\"certificate_of_authenticity\":true,\"coa_by_authenticating_body\":null,\"coa_by_gallery\":true,\"collecting_institution\":\"\",\"condition_description\":\"very good condition\",\"confidential_notes\":\"\",\"depth\":\"\",\"ecommerce\":true,\"exhibition_history\":\"\",\"external_id\":null,\"featured_slot\":null,\"framed\":false,\"framed_depth\":\"\",\"framed_height\":\"\",\"framed_width\":\"\",\"framed_diameter\":null,\"framed_metric\":\"in\",\"height\":\"17.3\",\"image_rights\":\"\",\"import_source\":null,\"inventory_id\":\"\",\"literature\":\"Catalogue Raisonne: Axsom 250\",\"medium\":\"Lithograph and silkscreen on white Lana mould-made paper\",\"not_signed\":false,\"offer\":false,\"partner_location_id\":\"5748d22f139b21265b000352\",\"pickup_available\":true,\"price_currency\":\"USD\",\"price_includes_tax\":false,\"price_listed\":15000.0,\"price_max\":15000.0,\"price_min\":15000.0,\"provenance\":\"Acquired from the private collection and estate of Wolf Kahn and Emily Mason\",\"series\":\"\",\"shipping_weight\":\"\",\"shipping_weight_metric\":\"lb\",\"signature\":\"Signed, dated and annotated 'AP.16 F. Stella 97' in pencil\",\"signed_by_artist\":true,\"signed_in_plate\":false,\"signed_other\":false,\"stamped_by_artist_estate\":false,\"sticker_label\":false,\"title\":\"Prince of Hohenfliess (Axsom 250)\",\"width\":\"12.5\",\"artists\":[\"frank-stella\"],\"price_hidden\":\"false\",\"display_price_range\":\"false\",\"availability_hidden\":\"false\",\"availability\":\"for sale\",\"diameter\":null,\"duration\":null,\"metric\":\"in\",\"manufacturer\":null,\"publisher\":\" Tyler Graphics, Ltd., Mount Kisco, New York for Axel Springer Verlag AG, Hamburg, Germany.\",\"domestic_shipping_fee_cents\":\"\",\"international_shipping_fee_cents\":\"\"}"


