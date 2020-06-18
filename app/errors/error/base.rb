module Error
  class Base < StandardError
    attr_reader :status#, :message, :code
    
    def initialize(message = "Error", code = 4000, status = :bad_request)
      @message = message
      @code = code
      @status = status
    end
    # def code; end
    # def message; end

    def as_json(options = {})
      {
        errors: [
          {
            message: @message,
            code: @code
          }
        ]
      }
    end
  end
end