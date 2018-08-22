class UpdateProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :profile_type, :integer, null: false, default: 0
    add_column :profiles, :avatar_url, :string, null: true
    add_column :profiles, :cover_img, :string, null: true
    add_column :profiles, :city, :string, null: false, default: ''
    add_column :profiles, :do_marketplace_available, :boolean, null: false, default: false
    add_column :profiles, :company_size, null: true
    add_column :profiles, :turnover

    add_reference :profiles, :country, foreign_key: true
    add_reference :profiles, :industry, foreign_key: true
  end
end
