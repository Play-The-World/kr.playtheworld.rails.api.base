directories = [
  # 'core_ext',
  'utils',
]

# directories << 'seeder'# if Rails.env.development?

directories.each do |dir|
  Dir[File.join(__dir__, dir, '*.rb')].each { |file| require file }
end