require 'rails_helper'

RSpec.describe LiftPass, type: :model do
  let (:lift_pass) {build(:lift_pass)}

  it "should have valid factory" do
    expect(lift_pass).to be_valid
  end

  context "wtp number" do
    it "should be formatted \w+-\w+-\w+ for season" do
      expect(lift_pass.wtp_number).to match /\A\w+-\w+-\w+\z/
      expect(lift_pass).to be_valid
    end
    it "should be formatted \w+ for season" do
      lift_pass.season.begin_year = '2014'
      lift_pass.season.end_year = '2015'
      lift_pass.wtp_number = 'abceKKW09uuy'
      expect(lift_pass).to be_valid
    end

  end

  describe "create_ride_data" do

    before do
      @records = []
      @records << ["Day", "Time", "Lift", "Vert Feet"]
      @records << ["2015-12-06", "12:55:17", "Moonbeam", 675]
      @records << ["2015-12-13", "10:13:59", "Eagle Express I", 675]
      @records << ["Total", "90000"]
    end

    it "should create a new rides" do
      expect { lift_pass.create_ride_data(@records) }.to change {lift_pass.rides.count}.by(2)
    end

    it "should not create duplicate rides" do
      lift_pass.create_ride_data(@records)
      expect { lift_pass.create_ride_data(@records) }.to change {lift_pass.rides.count}.by(0)
    end

    it "should update total" do
      lift_pass.create_ride_data(@records)
      expect(lift_pass.total).to eq(90000)
    end

  end
end
