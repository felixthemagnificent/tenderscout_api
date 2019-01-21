class CreateScraperStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :scraper_statistics do |t|
      t.string :worker_name
      t.integer :scrapped

      t.timestamps
    end
  end
end
