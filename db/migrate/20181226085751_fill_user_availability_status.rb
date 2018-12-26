class FillUserAvailabilityStatus < ActiveRecord::Migration[5.1]
  def up
  	User.all.each { |e| e.not_available! }
  	User.all.each { |e| e.available! if e.profiles.try(:first).try(:do_marketplace_available)}
  end
end
