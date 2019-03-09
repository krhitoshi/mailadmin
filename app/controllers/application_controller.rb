class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def authorize
    @current_admin = Admin.find_by_username(session[:admin_username])

    unless @current_admin
      redirect_to login_url, alert: "You need to sing in."
    end
  end
end
