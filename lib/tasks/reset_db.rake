desc "reset DB"
task :reset => :environment do
  sh("rm -rf db")
  Rake::Task["db:drop"].invoke
  Rake::Task["railties:install:migrations"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
end