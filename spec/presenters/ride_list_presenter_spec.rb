require 'rails_helper'

RSpec.describe RideListPresenter do

  let(:lift_pass) { create(:lift_pass_with_rides) }
  let(:presenter) { RideListPresenter.new(lift_pass) }

  describe "new" do
    it "initializes with a lift_pass" do
      expect(presenter.lift_pass).to eq lift_pass
      expect(presenter.rides).to match_array(lift_pass.rides)
    end
  end

  describe "ride list" do
    it "returns days as keys" do
      expect(presenter.ride_list.keys.first).to eq(lift_pass.rides.first.day)
      expect(presenter.ride_list.keys.second).to eq(lift_pass.rides.last.day)
    end

    it "returns total_runs for a day" do
      expect(presenter.ride_list[lift_pass.rides.first.day][:total_runs]).to eq(3)
    end

    it "returns total_vert for a day" do
      expect(presenter.ride_list[lift_pass.rides.first.day][:raw_total_vert]).to eq(3175)
    end

    it "returns total_lifts for a day" do
      expect(presenter.ride_list[lift_pass.rides.last.day][:total_lifts]).to eq('Apex, Moonbeam')
    end
  end

end
