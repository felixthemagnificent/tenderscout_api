class CreateScraperLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :scraper_links do |t|
      t.string :link
      t.integer :status

      t.timestamps
    end
  end
end
