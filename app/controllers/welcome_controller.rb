class WelcomeController < ApplicationController
  def index
    @owners = Owner.all
  end

  def save_wtp
    err = []
    begin
      @lift_pass = LiftPass.find(params[:lift_pass_id])
      if params[:wtp_number].present?
        wtp_number = params[:wtp_number]
        @lift_pass.wtp_number = wtp_number
        @lift_pass.save!
      end
    rescue => e
      err << e
    ensure
      render text: {success: err.empty?, err: err.join(" ")}.to_json
    end
  end
end
