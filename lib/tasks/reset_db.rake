desc "reset DB (only for development)"
task reset: :environment do
  sh("rails db:environment:set RAILS_ENV=development")
  sh("rm -rf db")
  Rake::Task["db:drop"].invoke
  # Rake::Task["railties:install:migrations"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
end