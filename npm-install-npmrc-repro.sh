#! /bin/bash

# Remove any files from prior runs
rm -rf \
  ./package.json \
  ./package-lock.json \
  ./node_modules \
  ./.npmrc \
  ./storage \
  ./htpasswd

# Start npm registry
npx verdaccio -c ./config.yml &
VERDACCIO_PID="$!"
npx wait-on http://localhost:4873;

# Setup new .npmrc
export REGISTRY="http://localhost:4873/"
echo -e 'registry = ${REGISTRY}\nalways-auth = true' > ./.npmrc
node ./login.js

# Try installing packages
echo '{}' > package.json
npm i -S 'full-icu'                                                            # Error
npm i -S 'https://github.com/GrabCAD/full-icu-npm#fix-use-project-npmrc'       # Error
npm i -S 'https://github.com/dfrankland/full-icu-npm#fix-npmrc-config-install' # Works!

# Stop npm registry
kill $VERDACCIO_PID
