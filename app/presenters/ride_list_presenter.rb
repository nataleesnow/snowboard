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
    hash = Hash.new.tap { |h| lift_pass.rides.each { |r| h[r.day] ||= {} } }
    hash.keys.map {|k| hash[k].merge!({total_runs: total_runs(k), total_lifts: total_lifts(k), raw_total_vert: raw_total_vert(k), total_vert: total_vert(k)}) }
    hash
  end

  def human_number(num)
    num.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end

end
