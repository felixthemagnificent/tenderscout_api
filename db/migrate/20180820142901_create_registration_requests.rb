class CreateRegistrationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_requests do |t|
      t.string :fullname, null: false, default: ''
      t.string :company, null: false, default: ''
      t.integer :company_size, null: false, default: 0
      t.string :state
      t.string :country
      t.string :city
      t.string :sector
      t.string :turnover
      t.json :markets
      t.integer :tender_level
      t.string :win_rate
      t.integer :number_public_contracts
      t.json :do_use
      t.boolean :do_collaborate
      t.float :tender_complete_time
      t.integer :organisation_count
      t.boolean :do_processed
      t.timestamps

      t.references :country, foreign_key: true
      t.references :industry, foreign_key: true
    end
  end
end
