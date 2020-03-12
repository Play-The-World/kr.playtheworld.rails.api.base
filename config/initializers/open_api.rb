require 'open_api'

OpenApi::Config.class_eval do
  # Part 1: configs of this gem
  self.file_output_path = './'

  # Part 2: config (DSL) for generating OpenApi info
  open_api :playtheworld_api, base_doc_classes: [V1::BaseController]
  info version: '1.0.0', title: 'PLAYTHEWORLD API', description: "API"
  # server 'http://localhost:3000', desc: 'Internal staging server for testing'
  # bearer_auth :Authorization
end

OpenApi.write_docs if: !Rails.env.production?