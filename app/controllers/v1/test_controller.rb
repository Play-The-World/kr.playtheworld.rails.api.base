module V1
  class TestController < BaseController
    def job
      # Model::TestJob.perform_later
      # ::HardWorker.perform_async('bob')
      Model::TestJob.perform_async
    end
    def pusher
      Model::Pusher.trigger('UserChannel1', 'message', { message: "hello" })
    end
  end
end
