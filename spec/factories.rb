FactoryGirl.define do
  factory :ride do
    vert 1500
    lift_pass
    day '2015-12-13'
    begin_time '11:43:52'
    lift "Moonbeam"
  end

  factory :season do
    begin_year '2015'
    end_year '2016'
  end

  factory :lift_pass do
    service_url "http://skisolitude.com"
    wtp_number "1abc-d3ef-GHIH"
    season
    owner
    total 300_000
  end

  factory :owner do
    name "nat"
  end

end
