class PagesController < ApplicationController
  before_action :authenticate_admin!, only: [:setgympage, :setgym]

  def index
  end

  def paid
  end

  def unpaid
  end

  def incorrectgym
  end

  def setgympage
  	@gyms = Gym.all
  end

  def setgym
  	cookies[:gym_id] = {
  		value: params[:gym_id],
  		expires: 20.years.from_now
  	}
  	redirect_to admin_root_path
  	flash[:notice] = "Local Gym Set"
  end
end
