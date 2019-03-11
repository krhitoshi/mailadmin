class SessionsController < ApplicationController
  skip_before_action :authorize
  layout "signin"

  def new
  end

  def create
    admin = Admin.active.find_by_username(params[:username])
                &.authenticate(params[:password])
    if admin
      session[:admin_username] = admin.username
      redirect_to root_url
    else
      redirect_to login_path, alert: "Incorrect username or password."
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
