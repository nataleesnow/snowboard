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

    factory :lift_pass_with_rides do
      after(:create) do |lift_pass|
        lift_pass.rides << create(:ride, begin_time: '1:29:00', day: '2015-12-14', vert: 1000, lift: 'Apex')
        lift_pass.rides << create(:ride, begin_time: '2:29:00', day: '2015-12-14', vert: 1500, lift: 'Eagle')
        lift_pass.rides << create(:ride, begin_time: '3:29:00', day: '2015-12-14', vert: 675, lift: 'Moonbeam')

        lift_pass.rides << create(:ride, begin_time: '1:29:00', day: '2015-12-24', vert: 1000, lift: 'Apex')
        lift_pass.rides << create(:ride, begin_time: '3:29:00', day: '2015-12-24', vert: 675, lift: 'Moonbeam')
      end
    end

  end

  factory :owner do
    name "nat"
  end

end
