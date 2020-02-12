require 'rdoc/task'

desc "RDoc"
task doc: :environment do
  sh("rm -rf doc")
  Rake::Task["rdoc:app"].invoke
end

namespace :rdoc do
  RDoc::Task.new("app") { |rdoc|
    version = File.exist?('VERSION') ? File.read('VERSION') : ""
    rdoc.rdoc_dir = 'doc'
    # rdoc.generator = 'hanna'
    rdoc.main = 'README.md'
    rdoc.template = ENV['template'] if ENV['template']
    rdoc.title = ENV['title'] || "PlayTheWorld #{version} Documentation"
    rdoc.options << '--line-numbers'
    rdoc.options << '--charset' << 'utf-8'
    # rdoc.options << '--locale' << 'ko'
    rdoc.rdoc_files.include('README*', 'app/**/*.rb', 'lib/**/*.rb', 'engines/model/app/**/*.rb', 'engines/model/lib/**/*.rb')
  }
  Rake::Task['rdoc:app'].comment = "Generate docs for the app -- (options: TEMPLATE=/rdoc-template.rb, TITLE=\"Custom Title\")"
end