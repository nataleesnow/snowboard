require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "responds successfully with HTTP 200 status" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns owners" do
      get :index
      owner = create(:owner)
      expect(assigns(:owners).last).to eq(owner)
    end

  end

  describe "#save_wtp" do
    let (:lift_pass) { create(:lift_pass) }

    it "finds a lift pass" do
      get :save_wtp, {lift_pass_id: lift_pass.id}
      expect(assigns(:lift_pass)).to eq(lift_pass)

    end

    it "renders text result" do
      get :save_wtp, {lift_pass_id: lift_pass}
      expect(response.body).to match(/"success":true/)
    end

    it "assigns a lift_pass wtp_number to a lift pass" do
      valid_wtp_number = "abc-def-h"
      get :save_wtp, {lift_pass_id: lift_pass.id, wtp_number: valid_wtp_number}
      expect(assigns(:lift_pass).wtp_number).to eq(valid_wtp_number)
      expect(response.body).to match(/"success":true/)
    end


    it "renders error text if wtp_number is invalid" do
      invalid_wtp_number = "abc"
      get :save_wtp, {lift_pass_id: lift_pass.id, wtp_number: invalid_wtp_number}
      expect(response.body).to match(/"success":false/)
    end
  end

end
