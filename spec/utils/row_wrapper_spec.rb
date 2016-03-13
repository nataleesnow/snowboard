require 'rails_helper'

RSpec.describe RowWrapper do

  let(:data) { ["2015-04-01", "10:45:23", "Moonbeam", "675"] }

  describe "new" do
    it "should return row" do
      expect(RowWrapper.new(data).row).to match_array(data)
    end
  end

  describe "empty?" do
    it "should true if nil row" do
      expect(RowWrapper.new(nil).empty?).to be_truthy
    end
    it "should true if blank row" do
      expect(RowWrapper.new(["", " ", "    "]).empty?).to be_truthy
    end
  end
end
