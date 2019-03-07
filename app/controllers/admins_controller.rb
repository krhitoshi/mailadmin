class AdminsController < ApplicationController
  before_action :set_admin, only: [:edit, :update]

  def index
    @admins = Admin.all
  end

  def update
    if @admin.update(admin_params)
      redirect_to admins_path, notice: 'Admin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:active)
  end
end
