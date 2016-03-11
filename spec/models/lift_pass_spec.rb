require 'rails_helper'

RSpec.describe LiftPass, type: :model do
  let (:lift_pass) {build(:lift_pass)}

  it "should have valid factory" do
    lift_pass.should be_valid
  end

  context "wtp number" do
    it "should be formatted \w+-\w+-\w+ for season" do
      expect(lift_pass.wtp_number).to match /\A\w+-\w+-\w+\z/
    end
    it "should be formatted \w+ for season" do
      lift_pass.season.begin_year = '2014'
      lift_pass.season.end_year = '2015'
      lift_pass.wtp_number = 'abceKKW09uuy'
      lift_pass.should be_valid
    end

  end
end
