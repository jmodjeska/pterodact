class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  private
    def current_user
      warden.user
    end
    helper_method :current_user

    def user_links
     if warden.user
      [ OpenStruct.new(name: 'Sign Out', target: sign_out_path) ]
    else
      [ OpenStruct.new(name: 'Sign In', target: sign_in_path) ]
     end
    end
    helper_method :user_links

    def display_navbar_logged_in
      if warden.user
        'render navbar_logged_in'
      end
    end
    helper_method :display_navbar_logged_in

    def authorize
      alert = 'Hi there. You are not signed in yet. How about we do that now?'
      redirect_to sign_in_url, alert: alert if current_user.nil?
    end

    def warden
      env['warden']
    end
end
