require 'rails_helper'

RSpec.describe Season, type: :model do
  let (:season) {build(:season)}

  it "should have valid factory" do
    season.should be_valid
  end

end
