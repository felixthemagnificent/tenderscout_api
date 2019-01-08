class AddWorkerNameToScraperLink < ActiveRecord::Migration[5.1]
  def change
    add_column :scraper_links, :worker_name, :string
  end
end
