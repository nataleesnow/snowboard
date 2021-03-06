class LiftPassController < ApplicationController
  before_filter :find_lift_pass, only: :index

  helper_method :human_number

  def index
    @presenter = RideListPresenter.new(@lift_pass)
  end

  def save_wtp
    err = []
    begin
      @lift_pass = LiftPass.find(params[:lift_pass_id])
      if params[:wtp_number].present?
        wtp_number = params[:wtp_number]
        wtp_number = if wtp_number.is_a?(Array) && wtp_number.count > 1
                       wtp_number = wtp_number.map(&:strip).join("-").gsub(' ', '')
                     elsif wtp_number.is_a?(Array)
                       wtp_number = wtp_number.map(&:strip).join("")
                     end
        @lift_pass.wtp_number = wtp_number
        @lift_pass.save!
      end
    rescue => e
      err << e
    ensure
      render text: {success: err.empty?, err: err.join(" ")}.to_json
    end
  end

  def day_ride
    ride = Ride.find(params[:id])
    @rides = Ride.where(lift_pass_id: ride.lift_pass_id).by_day(ride.day)
    render :day_ride, layout: false
  end

  def human_number(num)
    num.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end

  private

  def find_lift_pass
    @lift_pass = LiftPass.find(params[:id])
  end
end
