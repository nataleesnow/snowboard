LiftPass.delete_all
Owner.delete_all
Season.delete_all
SERVICE_URL = "http://shop.skisolitude.com/ride-data?view=ridedata&task=getTransactions&filter_wtp="
#owners = Owner.create([{ name: 'Ryan' }, { name: 'Natalee' }])
owners = Owner.create([{ name: 'Natalee' }])
seasons = Season.create([{ begin_year: '2013', end_year: '2014' }, { begin_year: '2014', end_year: '2015' }, { begin_year: '2015', end_year: '2016' }])
owners.each do |o|
  seasons.each do |s|
    LiftPass.create!({owner_id: o.id, season_id: s.id, service_url: SERVICE_URL})
  end
end

# Seed for Natalees year.
owner = Owner.where(name: 'Natalee').first
LiftPass.for_owner(owner.id).for_season(Season.find_by_end_year('2016').id).first.update_attribute('wtp_number', 'P5820187-28N-1NY')
LiftPass.for_owner(owner.id).for_season(Season.find_by_end_year('2015').id).first.update_attribute('wtp_number', '5e898450-a89-837')
LiftPass.for_owner(owner.id).for_season(Season.find_by_end_year('2014').id).first.update_attribute('wtp_number', 'AC760304-B38-986')
