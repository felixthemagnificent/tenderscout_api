require 'sidekiq'

if defined?(Sidekiq)
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://127.0.0.1:6379/0' }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://127.0.0.1:6379/0' }
    config.on(:startup) do
      Scrapers::ScrapeTendersJob.perform_later
    end
  end
end