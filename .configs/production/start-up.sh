#! /bin/sh

# Wait for DB services
# sh ./.configs/production/wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
# sh ./.configs/production/prepare-db.sh

# Pre-comple app assets
# sh ./asset-pre-compile.sh

rm -f /app/tmp/pids/server.pid

# Start Application
# bundle exec puma -C config/puma.rb
bundle exec rails server -b 0.0.0.0 -p 3000
