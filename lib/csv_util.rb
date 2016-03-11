require 'csv'
module CsvUtil

  def self.create_csv_file(filename, data)
    CSV.open(filename, "wb", :col_sep => ",", :row_sep => "\n") do |csv|
      csv << ['Day', 'Time', 'Lift', 'Vert Feet']
      data.each { |row| csv << row }
    end
  end

  def self.read_csv_file(filename)
    rows = []
    CSV.open(filename, "r").each_with_index do |csv, i|
      rows << csv
    end
    rows
  end

  def self.html_to_csv(data, el_id)
    rows = []
    converted = []
    rows = (data/"#{el_id}").search("tr")
    rows.each{|tr| converted << tr.search("td").innerHTML.strip.split("\n").map(&:strip)}
    converted.reject!(&:empty?)
  end
end
