class RideController < ApplicationController
  before_filter :find_owner

  def index
  end

  private

  def find_owner
    @owner = Owner.find(params[:id])
  end
end
