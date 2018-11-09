class SearchMonitor::MonitorExport < ApplicationJob
  require 'csv'
  require 'tempfile'
  queue_as :default

  def perform(results)
    temporary_name = SearchMonitor::MonitorExport.temp_name 'monitor_export_'
    header = ['Title', 'Description', 'Buyer','Low Value', 'High Value', 'Dispatch Date', 'Submission Date']
    Tempfile.open([temporary_name, ".csv"],Rails.root.join('tmp')) do |outfile|
      CSV.open(outfile, "wb") do |csv|
      csv << header
      results.each do |e|
        csv << [e.title,e.description,e.organization,e.estimated_low_value,e.estimated_high_value,e.dispatch_date,e.submission_date]
      end
    end
    end
  end

  def self.temp_name(file_name='', ext='', dir=nil)
    id   = Thread.current.hash * Time.now.to_i % 2**32
    name = "%s%d.%s" % [file_name, id, ext]
  end
end