# Custom Seed

desc "Custom Seed // usage: rails db:seed:file_name (without .rb)"
namespace :seed do
  Dir[File.join(Rails.root, 'seeds', '*.rb')].each do |filename|
    task_name = File.basename(filename, '.rb').intern
    task task_name => :environment do
      if File.exist?(filename)
        load(filename)
      else
        puts "Could not find #{task_name}.rb"
      end
    end
  end
end