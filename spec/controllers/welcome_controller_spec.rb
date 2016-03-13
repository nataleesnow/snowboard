require 'rails_helper'

RSpec.describe WelcomeController do

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

end
