class AddMarketplaceStatusToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :marketplace_status, :integer
  end
end
