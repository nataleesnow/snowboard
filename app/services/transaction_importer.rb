require 'net/http'
require 'hpricot'
require 'open-uri'
require 'csv_util'

class TransactionImporter

  attr_reader :service_url, :lift_pass, :csv_file

  attr_accessor :data, :err_log

  TAG_ID = "#ridedata"

  def initialize(lift_pass)
    @lift_pass = lift_pass
    @data = nil
    @err_log = Logger.new File.join(Rails.root, 'log', "import.err")
  end

  def service_url
    @_service_url ||= lift_pass.service_url + lift_pass.wtp_number
  end

  def csv_file
    @_csv_file ||= File.join(Rails.root, 'public', "csv_transacations_#{lift_pass.wtp_number}.csv")
  end

  # Attempt to retrieve live data from the resort website.
  def get_transactions
    begin
      fetch_html
      check_data
      write_csv
    rescue Exception => e
      err_log << "#{e.backtrace} #{e.message}"
    end
  end

  def create_records
    begin
      raise if !File.exist? csv_file
      records = CsvUtil.read_csv_file(csv_file)
      total = records.pop
      header = records.shift
      ActiveRecord::Base.transaction do
        records.map{|row| p TransactionRow.new(row) }.each do |record|
          next if record.empty?
          p record.day
          p record.begin_time
          p record.vert
          p record.lift
          #err_log << Ride.insert_record(record)
        end
        #raise ActiveRecord::Rollback if errors.present?
      end
    rescue Exception => e
      err_log << "#{e.backtrace} #{e.message}"
    end
  end

  private

  def fetch_html
    uri = URI(service_url)
    Rails.logger.info "Getting response from \t\t#{uri}.....\n\n"
    self.data = open(uri) { |f| Hpricot(f) }
  end

  def check_data
    unless data.nil?
      if (data/"#{TAG_ID}").empty? || (data/".note").inner_html.match(/No data found/)
        err_log << "No Data Found for data: #{data}"
      end
    else
      err_log << "Empty Data"
    end
  end

  def write_csv
    if !data.nil? && errors.empty?
      CsvUtil.create_csv_file(csv_file, CsvUtil.html_to_csv(data, TAG_ID))
    end
  end

end
