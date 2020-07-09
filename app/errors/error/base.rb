module Error
  DEFAULT_MESSAGE = "알 수 없는 에러"
  DEFAULT_CODE = 4999
  DEFAULT_STATUS = :bad_request

  class Base < StandardError
    attr_reader :status#, :message, :code
    
    def initialize(message = nil, code = nil, status = nil)
      @message = message
      @code = code
      @status = status
      @message ||= DEFAULT_MESSAGE
      @code ||= DEFAULT_CODE
      @status ||= DEFAULT_STATUS
    end
    # def code; end
    # def message; end

    def as_json(options = {})
      {
        errors: [
          {
            message: @message,
            # code: @code
          }
        ]
      }
    end
  end
end