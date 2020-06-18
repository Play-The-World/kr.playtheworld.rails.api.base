class JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt[:secret_key_base]
  SALT_LENTH = 10

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:salt] = SecureRandom.hex(SALT_LENTH)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY, false)[0]
      HashWithIndifferentAccess.new(decoded.except("salt"))
    end
  end
end