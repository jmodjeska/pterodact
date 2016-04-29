class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
    flash.now[:alert] = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url
  end

  def destroy
    reset_session
    redirect_to sign_in_path
  end
end
