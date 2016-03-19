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
    1..6.times { |t|
      cur_month = start_date.next_month(t).strftime("%b")
      start_date.next_month(t).step(start_date.next_month(t).end_of_month).each_with_index do |slice, i|
        cal[cur_month] ||= []
        1..(slice.wday).times do |p|
          cal[cur_month].unshift("") if i == 0
        end
        cal[cur_month] << slice
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
    hash = Hash.new.tap { |h| lift_pass.rides.each { |r| h[r.day] ||= {ride_id: r.id} } }
    hash.keys.map {|k| hash[k].merge!({
      total_runs: total_runs(k), total_lifts: total_lifts(k), raw_total_vert: raw_total_vert(k), total_vert: total_vert(k)
    }) }
    hash
  end

  def human_number(num)
    num.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end

  def cal_date(year, month, day)
  end

end
