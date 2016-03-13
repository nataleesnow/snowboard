require 'rails_helper'

RSpec.describe Season, type: :model do
  let (:season) {build(:season)}

  it "should have valid factory" do
    expect(season).to be_valid
  end

end
