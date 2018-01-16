#!/bin/bash

# CLONE REPOS
git clone git@github.com:TheRealCodeKraft/obl-tools tools
echo -e
git clone git@github.com:TheRealCodeKraft/obl-api api
echo -e
git clone git@github.com:TheRealCodeKraft/obl-client frontend
echo -e
git clone git@github.com:TheRealCodeKraft/codekraft-ruby-api
echo -e
git clone git@github.com:TheRealCodeKraft/codekraft-react-frontend

# BUILD
if [ ! -f tools/.env ]; then
  echo "COMPOSE_PROJECT_NAME=open-business-labs" >> tools/.env
  echo "GITHUB_TOKEN=312f67d0d28b3e06c58cffd212f4e25c2875aa24" >> tools/.env
  echo "DB_USER=open-business-labs" >> tools/.env
  echo "DB_PASS=open-business-labs" >> tools/.env
  echo "DB_NAME=open-business-labs" >> tools/.env
fi

if [ ! -f api/.env ]; then
  echo "S3_BUCKET_NAME=media-dev.openbusinesslabs.com" >> api/.env
  echo "AWS_ACCESS_KEY_ID=AKIAISAQCWSOGI5TGWLA" >> api/.env
  echo "AWS_SECRET_ACCESS_KEY=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" >> api/.env
  echo "AWS_REGION=eu-west-2" >> api/.env
  echo "S3_BUCKET_URL=https://s3.eu-west-2.amazonaws.com" >> api/.env

  echo "DATABASE_URL=postgresql://open-business-labs:open-business-labs@postgres/open-business-labs" >> api/.env
fi

if [ ! -f frontend/.env ]; then
  echo "CLIENT_ID=2827aff5b3506bcf5cf7fd33ebf4903aec4abf82e202df748175dd051b8c2846" >> frontend/.env
  echo "CLIENT_SECRET=8bbfa7ecf781fe7590a12ce3a23ad3481efdfa27d93bc42e8d62b0ef0c03794f" >> frontend/.env
  echo "APP_TOKEN=11dec774b37a3dd9e0d26e1a57796f1d46cbf71a74146bdd5a90b11ffe2abfb2" >> frontend/.env
  echo "API_URL=http://localhost:3000/v1/" >> frontend/.env
  echo "CLIENT_GRANT_TYPE='client_credentials'" >> frontend/.env
  echo "CABLE_URL=http://localhost:3000/cable" >> frontend/.env
fi

./tools/cook-build

# INIT DB
./tools/cook-db
./tools/cook-seed

# CLEAR
./tools/rebuild-front-lib
./tools/cook-down
