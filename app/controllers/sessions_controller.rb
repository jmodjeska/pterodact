class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def new
    flash.now[:alert] = warden.message if warden.message.present?
  end
  
  def create
    warden.authenticate!
    redirect_to root_url, notice: "Logged in."
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to landing_path, notice: "Signed out. Bye bye!"
  end
end
