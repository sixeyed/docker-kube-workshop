# requires environment variables: DTR_HOST, DTR_USERNAME and DTR_API_KEY

DTR_API_URL=https://$DTR_HOST/api/v0

# set read-write access for CI

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-web/teamAccess/ci \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-write"
}'

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-api/teamAccess/ci \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-write"
}'

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-db/teamAccess/ci \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-write"
}'

# set read-only access for humans

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-web/teamAccess/humans \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-only"
}'

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-api/teamAccess/humans \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-only"
}'

curl -X PUT -k -sL \
  -u $DTR_USERNAME:$DTR_API_KEY \
  $DTR_API_URL/repositories/dockersamples/hybrid-app-db/teamAccess/humans \
  -H 'Content-Type: application/json' \
  -d '{
  "accessLevel": "read-only"
}'

