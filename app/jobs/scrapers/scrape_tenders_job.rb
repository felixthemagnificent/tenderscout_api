class Scrapers::ScrapeTenders < ApplicationJob
  queue_as :scrapers

  def perform
    available_scrapers.each do |scraper|
      scraper_klass = scraper[:klass]
      scraper.run_at.each do |run_time|
        run_time = Chronic.parse(run_time)
        if ((DateTime.now - 2.minute < run_time) and (run_time < DateTime.now + 2.minutes))
          scraper_klass.constantize.perform_later unless is_running?(scraper_klass)
        end
      end
    end
  end

  private

  def is_running?(scraper_klass)
    job_classes = Sidekiq::Workers.new.map { |_,_,e| p e['payload']['wrapped'] }
    job_classes.include?(scraper_klass)
  end

  def available_scrapers
    [
      { 
        klass: 'Scrapers::EbrdJob',
        run_at:['7am', '12pm', '5pm']
      },
      {
        klass: 'Scrapers::FboGovJob',
        run_at: ['7am', '12pm', '5pm']
      },
      {
        klass: 'Scrapers::BuyAndSellJob',
        run_at: ['7am', '12pm', '5pm']
      },
      {
        klass: 'Scrapers::BuyAndSellAwards',
        run_at: ['7am', '12pm', '5pm']
      },
    ]
  end
end
