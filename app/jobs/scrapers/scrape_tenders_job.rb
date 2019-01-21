class Scrapers::ScrapeTendersJob < ApplicationJob
  queue_as :scrapers

  def perform
    is_wait = true
    available_scrapers.each do |scraper_klass|
      scraper_klass.constantize.perform_later
    end 

    while is_wait
      is_wait = false
      available_scrapers.each do |scraper_klass|
        is_wait ||= true if is_running?(scraper_klass)
      end 
    end
    Scrapers::ScrapeTendersJob.perform_later
  end

  private

  def is_running?(scraper_klass)
    job_classes = Sidekiq::Workers.new.map { |_,_,e| p e['payload']['wrapped'] }
    job_classes.include?(scraper_klass)
  end

  def is_scheduled?(scraper_klass)
    Sidekiq::ScheduledSet.new.any? {|job| job.klass == e }
  end

  def available_scrapers
    ['Scrapers::EbrdJob', 'Scrapers::FboGovJob', 'Scrapers::BuyAndSellJob', 'Scrapers::BuyAndSellAwardsJob']
  end
end
