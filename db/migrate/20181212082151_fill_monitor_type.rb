class FillMonitorType < ActiveRecord::Migration[5.1]
  def change
  	SearchMonitor.where.not(monitor_type: :profile).each { |e| e.personal! }
  end
end
