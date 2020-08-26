class HardWorker
  include Sidekiq::Worker

  def perform(name)
    # do something
    puts "hello"
  end
end