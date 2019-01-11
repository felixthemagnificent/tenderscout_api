class CreateBidNoBidDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_bid_no_bid_deadlines do |t|
      t.datetime :deadline
      t.integer :collaboration_id
      t.integer :bid_no_bid_question_id
    end
  end
end
