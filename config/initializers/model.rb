Model.configure do |config|
  # One Time Password
  # length of OTP
  # config.otp_digits = 6
  # expiry time
  # config.top_expiry_time = 3.minutes

  # Pusher
  config.pusher = Pusher
  # config.disable_pusher = false
end