require 'rails_helper'

RSpec.describe TransactionImporter, type: :service do

  describe "new" do

    let(:lift_pass) { build(:lift_pass) }

    it "initializes with a lift_pass" do
      ti = TransactionImporter.new(lift_pass)
      expect(ti.lift_pass).to eq lift_pass
    end

    it "returns a service url" do
      ti = TransactionImporter.new(lift_pass)
      expect(ti.service_url).to eq lift_pass.service_url+lift_pass.wtp_number
    end

  end

  describe "get_transactions" do
  end

end
