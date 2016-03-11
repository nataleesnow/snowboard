class LiftPass < ActiveRecord::Base
  belongs_to :owner
  has_many :rides
  belongs_to :season
  validates :season_id, :owner_id, :service_url, presence: true
  validate :wtp_number_format, if: "wtp_number.present?"

  def wtp_number_format
    if self.season && self.season.begin_year == "2015"
      errors.add(:wtp_number_format, "must be in \w+-\w+-\w+ format") unless wtp_number =~ /\A\w+-\w+-\w+\z/
    end
  end

  scope :for_owner, ->(owner_id) { where(owner_id: owner_id) }
  scope :for_season, ->(season_id) { where(season_id: season_id) }
end
