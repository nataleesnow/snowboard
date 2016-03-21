require 'rails_helper'

RSpec.describe LiftPassController do

  let (:lift_pass) { create(:lift_pass) }

  describe "GET #index" do
    it "responds successfully with HTTP 200 status" do
      get :index, {id: lift_pass.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "render the index template" do
      get :index, {id: lift_pass.id}
      expect(response).to render_template("index")
    end

    it "assigns lift_pass" do
      get :index, {id: lift_pass.id}
      expect(assigns(:lift_pass)).to eq(lift_pass)
    end

  end

  xdescribe "#save_wtp" do
    let (:lift_pass) { create(:lift_pass) }

    it "finds a lift pass" do
      get :save_wtp, {lift_pass_id: lift_pass.id}
      expect(assigns(:lift_pass)).to eq(lift_pass)

    end

    it "assigns a lift_pass wtp_number to a lift pass" do
      valid_wtp_number = ["abc", "def", "h"]
      get :save_wtp, {lift_pass_id: lift_pass.id, wtp_number: valid_wtp_number}
      expect(assigns(:lift_pass).wtp_number).to eq(valid_wtp_number.join("-"))
      expect(response.body).to match(/"success":true/)
    end


    it "renders error text if wtp_number is invalid" do
      invalid_wtp_number = ["abc"]
      get :save_wtp, {lift_pass_id: lift_pass.id, wtp_number: invalid_wtp_number}
      expect(response.body).to match(/"success":false/)
    end
  end

end
