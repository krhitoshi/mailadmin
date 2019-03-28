class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def set_active_domain
    @domain = Domain.find(params[:domain_id])
    raise "Invalid domain access" unless @current_admin.has_domain?(@domain)

    if @domain.inactive? && !@current_admin.super_admin?
      raise "Invalid domain access"
    end
  end

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
