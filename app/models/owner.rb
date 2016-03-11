class Owner < ActiveRecord::Base
  has_many :lift_passes
  validates :name, presence: true

end
