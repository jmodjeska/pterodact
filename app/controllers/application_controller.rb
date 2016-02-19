class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  private
    def current_user
      warden.user
    end
    helper_method :current_user

    def authorize
      redirect_to sign_in_url, alert: 'Hi there. You are not signed in yet. How about we do that now?' if current_user.nil?
    end
    
    def warden
      env['warden']
    end
end
