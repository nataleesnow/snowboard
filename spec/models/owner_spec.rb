require 'rails_helper'

RSpec.describe Owner, type: :model do
  let (:owner) {build(:owner)}

  it "should have valid factory" do
    owner.should be_valid
  end

end
