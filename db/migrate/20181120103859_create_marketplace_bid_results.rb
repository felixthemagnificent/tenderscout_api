class CreateMarketplaceBidResults < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_bid_results do |t|
      t.string :bid_result_type
      t.integer :big_result_id
      t.string :name
      t.string :max_score
      t.string :estimate_score
      t.string :actual_score
      t.string :winning_score
      t.integer :section_id
      t.integer :tender_id
      t.integer :collaboration_id
    end
  end
end
