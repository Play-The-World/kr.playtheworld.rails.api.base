#! /bin/sh

# Wait for DB services
sh ../../wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
sh ./prepare-db.sh

# Pre-comple app assets
# sh ./asset-pre-compile.sh

# Start Application
# bundle exec puma -C ../../../config/puma.rb
bundle exec rails server -b 0.0.0.0 -p 3000