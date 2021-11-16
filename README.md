# Artsy Public API

You should be looking at [developers.artsy.net](https://developers.artsy.net) unless someone at Artsy directed you here. This API is *not* for public consumption and is subject to change without notice.

# APIv1

The Artsy platform has an internal API, otherwise known as APIv1. Plug *https://api.artsy.net/api/v1/swagger_doc* into the [Petstore Swagger UI](https://petstore.swagger.io) to see it.

This repository contains some working samples that use APIv1.

# Steps to integrate with Artsy's v1 API

1. Navigate to https://developers.artsy.net/v1/start
1. If you don’t have an Artsy account already, create one
1. Click “Sign in into developer website” and sign into that account.
1. You should see an additional step now: “3. Create an App”, click on that
1. Give a name to your app (something like your company's name, for example “ArtInventory”, would work here) as well as redirect urls. These are the paths that users will be redirected to after authenticating with Artsy. You can leave the redirect urls field blank for now.
1. After clicking “Save”, you should see “Request Partner Access”, this is because you just created a client application record in our database but it’s currently set to hit v2 of our API, which are the hypermedia endpoints which aren’t partner facing and don't allow uploading of artworks.
1. Let us know when you get to this step! It would be useful to send over the client ID (and not the secret!), which you can find by going to https://developers.artsy.net/client_applications, or by clicking “My Apps”. I will then flip you over to hit v1 of our API.
1. After your client app is set to hit v1, go back to https://developers.artsy.net/v1/start, and you’ll see additional steps laid out for redirecting your users to Artsy’s authentication and how Artsy will redirect them back after login with an access token.
1. You’ll want to populate your redirect urls correctly at this point. You can do that by going to https://developers.artsy.net/client_applications (or “My Apps”), clicking “edit”, and adding redirect urls to that field, one url per new line.
1. The rest of the steps at https://developers.artsy.net/v1/start should be fairly straightfoward!
1. Take a look at some sample requests that use the access token to hit Artsy’s API: https://github.com/artsy/artsy-api-v1-samples/
1. Be sure to add your company name (i.e. "ArtInventory") as `import_source` and your system's unique id for that artwork as `external_id` for syncing
