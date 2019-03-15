class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def super_admin_check
    raise "Ivalid admin access" unless @current_admin.super_admin?
  end

  def authorize
    @current_admin = Admin.active.find_by_username(session[:admin_username])

    unless @current_admin
      redirect_to login_url, alert: "You need to sing in."
    end
  end
end
