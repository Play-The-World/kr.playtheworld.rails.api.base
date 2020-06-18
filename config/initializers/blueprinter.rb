Blueprinter.configure do |config|
  config.sort_fields_by = :definition
  # config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime("%s").to_i }
end