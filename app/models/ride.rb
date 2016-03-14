class Ride < ActiveRecord::Base
  belongs_to :lift_pass
  has_one :owner, through: :lift_pass
  validates :vert, :lift_pass_id, :day, :begin_time, presence: true
  validates :vert, numericality: true

  scope :by_day, ->(day) { where(day: day) }

end
