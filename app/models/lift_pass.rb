class LiftPass < ActiveRecord::Base
  belongs_to :owner
  has_many :rides
  belongs_to :season
  validates :season_id, :owner_id, :service_url, presence: true
  validate :wtp_number_format, if: "wtp_number.present?"

  scope :for_owner, ->(owner_id) { where(owner_id: owner_id) }
  scope :for_season, ->(season_id) { where(season_id: season_id) }

  def wtp_number_format
    if self.season && self.season.begin_year == "2015"
      errors.add(:wtp_number_format, "must be in \w+-\w+-\w+ format") unless wtp_number =~ /\A\w+-\w+-\w+\z/
    end
  end

  def create_ride_data(records)
    records.shift
    total = records.pop
    self.update_attribute("total", total.last)
    records.map{|row| p TransactionRow.new(row) }.each do |record|
      next if record.empty?
      self.rides.where(begin_time: record.begin_time_clean, day: record.day_clean).first_or_create do |ride|
        ride.begin_time = record.begin_time_clean
        ride.day = record.day_clean
        ride.vert = record.vert_clean
        ride.lift = record.lift_clean
      end
    end

  end

end
