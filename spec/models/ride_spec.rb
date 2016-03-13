require 'rails_helper'

RSpec.describe Ride do

  let (:ride)  { build(:ride) }

  it "should have valid factory" do
    expect(ride).to be_valid
  end



end
