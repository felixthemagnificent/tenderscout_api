Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = 'ActionController::API'
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.custom_options = lambda do |event|
    # NOTE: We must use lograge.custom_options or else lograge will only log the default info, even if extra info has been added to the notification payload
    event.payload
  end
  config.lograge.logger = LogStashLogger.new(type: :udp, host: '::1', port: 5228)
end