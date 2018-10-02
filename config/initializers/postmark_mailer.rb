PostmarkMailer.configure do |config|
  # config.api_key = Rails.application.secrets.postmark_api_token
  config.api_key = "2f791fbd-8c09-40a5-97f3-40d1138baa3f"
  config.default_delivery_queue = :mailers
end