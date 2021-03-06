#!/bin/bash

set -euxo pipefail

# Set up
"$( dirname "${BASH_SOURCE[0]}" )"/base.sh

# Copy the .env.test file, as this is normally not done during installation and we need it
cp webapp/.env.test /opt/domjudge/domserver/webapp/

cd /opt/domjudge/domserver

# Remove the generated .env.local.php file as this contains production data
rm webapp/.env.local.php
# Copy the .env.local file to .env as Symfony requires this when .env.local.php does not exist
cp webapp/.env.local webapp/.env

export APP_ENV="test"

# run phpunit tests
webapp/bin/phpunit -c webapp/phpunit.xml.dist --log-junit ${CI_PROJECT_DIR}/unit-tests.xml --coverage-text --colors=never
