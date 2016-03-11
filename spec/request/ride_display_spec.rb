require "rails_helper"

RSpec.describe "Ride display", type: :request do
  it "finds a rider and renders the rider data partial" do
    rider = create(:owner)
    get rider_data_path(rider.id)
    expect(response).to render_template("index")
    expect(response.body).to include("#{rider.name} has been on the slopes a lot!")
  end

end
