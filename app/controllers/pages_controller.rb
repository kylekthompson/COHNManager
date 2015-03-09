class PagesController < ApplicationController
  def index
  end

  def paid
  end

  def unpaid
  end

  def location
  end

  def incorrectgym
  end

  def setgympage
  	@gyms = Gym.all
  end

  def setgym
  	cookies[:gym_id] = params[:gym_id]
  	redirect_to admin_root_path
  	flash[:notice] = "Local Gym Set"
  end
end
