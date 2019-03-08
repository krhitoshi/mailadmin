class AdminsController < ApplicationController
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    params = admin_params.dup

    if params["password"] != params["password_confirmation"]
      params.delete("password_confirmation")
      @admin = Adminx.new(params)
      flash[:notice] = "Password mismatch"
      render action: 'new'
      return
    end

    params["password"] = DovecotCrammd5.calc(params["password"])
    params.delete("password_confirmation")
    @admin = Admin.new(params)

    if @admin.save
      redirect_to admins_path, notice: 'Admin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    params = admin_params.dup
    if params["password"]
      if params["password"] != params["password_confirmation"]
        params.delete("password_confirmation")
        @admin.attributes = params
        flash[:notice] = "Password mismatch"
        render action: 'edit'
        return
      end
      params["password"] = DovecotCrammd5.calc(params["password"])
      params.delete("password_confirmation")
    end
    if @admin.update(params)
      redirect_to admins_path, notice: 'Admin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @admin.destroy
    redirect_to admins_path
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:username, :password, :password_confirmation, :active)
  end
end
