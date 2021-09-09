# Only for test

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  included do
    connects_to database: { writing: :new_model, reading: :new_model }
  end
end

Rails.configuration.to_prepare do
  ActiveStorage::Record.include ActiveStorageAttachmentExtension
end
