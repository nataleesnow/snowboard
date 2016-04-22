class RideListPresenter

  attr_reader :lift_pass, :rides

  def initialize(lift_pass)
    @lift_pass = lift_pass
    @rides = lift_pass.rides
  end

  def ride_list
   @_ride_list ||= ride_hash
  end

  def best_day
    ride_list.sort_by{|k, v| v[:raw_total_vert]}.reverse.first
  end

  def total
    lift_pass.total
  end

  def days_of_week
    @_days_of_week ||= ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
  end

  def calendar
    start_date = Date.new(lift_pass.season.begin_year.to_i,11,1)
    cal = {}
    1..6.times { |month|
      cur_month = start_date.next_month(month).strftime("%B")
      start_date.next_month(month).step(start_date.next_month(month).end_of_month).each_with_index do |days, i|
        cal[cur_month] ||= []
        1..(days.wday).times do |x|
          cal[cur_month].unshift("") if i == 0
        end
        cal[cur_month] << days
      end
    }
    cal
  end

  private

  def total_vert(day)
    human_number(rides.where(day: day).map(&:vert).sum)
  end

  def raw_total_vert(day)
    rides.where(day: day).map(&:vert).sum
  end

  def total_runs(day)
    rides.where(day: day).count
  end

  def total_lifts(day)
    rides.where(day: day).map(&:lift).uniq.join(", ")
  end

  def ride_hash
    #hash = Hash.new.tap { |h| lift_pass.rides.each { |r| h[r.day] ||= {ride_id: r.id} } }
    ride_data = {}
    lift_pass.rides.each do |r|
      ride_data[r.day] ||= {ride_id: r.id}
    end
    ride_data.keys.map {|day| ride_data[day].merge!({
      total_runs: total_runs(day), total_lifts: total_lifts(day), raw_total_vert: raw_total_vert(day), total_vert: total_vert(day)
    }) }
    ride_data
  end

  def human_number(num)
    num.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end

end
