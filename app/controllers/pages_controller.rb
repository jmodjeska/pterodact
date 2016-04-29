class PagesController < ApplicationController
  skip_before_action :authorize, only: [:landing]

  def landing
  end
end
