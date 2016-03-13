require 'rails_helper'

RSpec.describe TransactionRow do

  let(:data) { ["2015-04-01", "10:45:23", "Moonbeam", "675"] }

  describe "wrap" do
    it "should return day" do
      tr = TransactionRow.new(data)
      expect(tr.day).to eq(data[0])
    end

    it "should return clean_day" do
      data = [" 2015-04-01 ", "10:45:23", "Moonbeam", "675"]
      tr = TransactionRow.new(data)
      expect(tr.day_clean).to eq("2015-04-01")
    end

    it "should return begin_time" do
      tr = TransactionRow.new(data)
      expect(tr.begin_time).to eq(data[1])
    end

    it "should return clean_begin_time" do
      data = [" 2015-04-01 ", "   10:45:23", "Moonbeam", "675"]
      tr = TransactionRow.new(data)
      expect(tr.begin_time_clean).to eq("10:45:23")
    end

    it "should return lift" do
      tr = TransactionRow.new(data)
      expect(tr.lift).to eq(data[2])
    end

    it "should return clean_lift" do
      data = [" 2015-04-01 ", "10:45:23", " Moonbeam   ", "675"]
      tr = TransactionRow.new(data)
      expect(tr.lift_clean).to eq("Moonbeam")
    end

    it "should return vert" do
      tr = TransactionRow.new(data)
      expect(tr.vert).to eq(data[3])
    end

    it "should return clean_vert" do
      data = [" 2015-04-01 ", "   10:45:23", "Moonbeam", "675    "]
      tr = TransactionRow.new(data)
      expect(tr.vert_clean).to eq("675")
    end


  end
end
