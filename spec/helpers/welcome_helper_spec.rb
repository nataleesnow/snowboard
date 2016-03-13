require 'rails_helper'

RSpec.describe WelcomeHelper do

  let (:lift_pass) { create(:lift_pass) }

  describe "#link_to_lift_pass" do
    context "wtp number exists" do
      it "includes the path to the lift pass" do
        expect(helper.link_to_lift_pass(lift_pass)).to include(lift_pass_path(lift_pass.id))
      end
    end
    context "wtp number does not exist" do
      it "includes the path to submit a wtp number" do
        lift_pass.wtp_number = ""
        expect(helper.link_to_lift_pass(lift_pass)).to include("supply_wtp")
      end
    end
  end
end
