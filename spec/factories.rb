FactoryGirl.define do

  factory :season do
    begin_year '2015'
    end_year '2016'
  end

  factory :lift_pass do
    service_url "http://skisolitude.com"
    wtp_number "1abc-d3ef-GHIH"
    season
    owner
  end
end
