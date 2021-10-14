require_relative 'config'

# Pusher.app_id = Rails.application.credentials.pusher[:app_id]
# Pusher.key = Rails.application.credentials.pusher[:key]
# Pusher.secret = Rails.application.credentials.pusher[:secret]
# Pusher.cluster = Rails.application.credentials.pusher[:cluster]

Pusher.app_id = Settings.pusher.app_id
Pusher.key = Settings.pusher.key
Pusher.secret = Settings.pusher.secret
Pusher.cluster = Settings.pusher.cluster

Pusher.encrypted = true
Pusher.logger = Rails.logger