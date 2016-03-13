class RowWrapper
  attr_reader :row
  def initialize(data)
    @row = data
  end

  def self.wrap(columns)
    columns.each_with_index do |name, idx|
      define_method(name.to_sym) do
        row[idx]
      end

      define_method("#{name}_clean") do
        value = self.send(name.to_sym) || ""
        value.to_s.split().join(' ').strip
      end
    end
  end

  def empty?
    if row.nil?
      return true
    end
    row.all?(&:blank?)
  end

end
