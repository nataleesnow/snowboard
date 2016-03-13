require 'net/http'
require 'hpricot'
require 'open-uri'
require 'csv_util'

class TransactionImporter

  attr_reader :service_url, :lift_pass, :csv_file

  attr_accessor :data, :err_log, :errors

  TAG_ID = "#ridedata"

  def initialize(lift_pass)
    @lift_pass = lift_pass
    @data = nil
    @err_log = Logger.new File.join(Rails.root, 'log', "import.err")
    @errors = []
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
      raise unless errors.empty?
      write_csv
    rescue Exception => e
      errors << "#{e.backtrace} #{e.message}\n\n"
      err_log << "#{e.backtrace} #{e.message}\n\n"
    end
  end

  def create_records
    begin
      raise if !File.exist? csv_file
      lift_pass.create_ride_data(CsvUtil.read_csv_file(csv_file))
    rescue Exception => e
      errors << "#{e.backtrace} #{e.message}\n\n"
      err_log << "#{e.backtrace} #{e.message}\n\n"
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
        errors << "No Data Found for data: #{data}\n\n"
        err_log << "No Data Found for data: #{data}\n\n"
      end
    else
      errors << "Empty Data\n\n"
      err_log << "Empty Data\n\n"
    end
  end

  def write_csv
    CsvUtil.create_csv_file(csv_file, CsvUtil.html_to_csv(data, TAG_ID))
  end

end
