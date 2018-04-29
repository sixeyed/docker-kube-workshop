# requires environment variables: DTR_HOST, DTR_USERNAME and DTR_API_KEY

DTR_API_URL=https://$DTR_HOST/api/v0

curl -X POST -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples \
  -H 'Content-Type: application/json' \
  -d '{
  "enableManifestLists": true,
  "immutableTags": true,
  "longDescription": "",
  "name": "hybrid-app-api",
  "scanOnPush": true,
  "shortDescription": ".NET Core API",
  "visibility": "public"
}'

curl -X POST -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples \
  -H 'Content-Type: application/json' \
  -d '{
  "enableManifestLists": true,
  "immutableTags": true,
  "longDescription": "",
  "name": "hybrid-app-db",
  "scanOnPush": true,
  "shortDescription": "MySQL Database",
  "visibility": "public"
}'

