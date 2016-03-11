class Season < ActiveRecord::Base
  validates :begin_year, :end_year, presence: true
  validates :begin_year, format: { with: /\A2[0-9]{3}\z/, message: "season begin year must be in 2yyy format" }
  validates :end_year, format: { with: /\A2[0-9]{3}\z/, message: "season end year must be in 2yyy format" }
end
