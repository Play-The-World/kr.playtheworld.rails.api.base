class Response
  attr_reader :message, :code

  def initialize(message: "", code: 4000)
    @message = message
    @code = code
  end

  def as_json
    {
      message: @message,
      code: @code
    }
  end
end