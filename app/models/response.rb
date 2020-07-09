class Response
  DEFAULT_MESSAGE = "성공!"
  DEFAULT_CODE = 2000
  DEFAULT_STATUS = :ok
  # attr_reader :message, :code

  def initialize(message = nil, code = nil)
    @message = message
    @code = code
    @message ||= DEFAULT_MESSAGE
    @code ||= DEFAULT_CODE
  end

  def as_json(options = {})
    {
      message: @message,
      # code: @code
    }
  end
end