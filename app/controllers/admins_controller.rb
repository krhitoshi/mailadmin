class AdminsController < ApplicationController
  before_action :super_admin_check, only: [:new, :create, :destroy]
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    if @current_admin.super_admin?
      @admins = Admin.all
      @super_admin = true
    else
      @admins = [@current_admin]
      @super_admin = false
    end
  end

  def new
    @admin = Admin.new
    @domains = Domain.all
  end

  def create
    params = admin_params.dup
    domains = params["domains"]
    params.delete("domains")

    @admin = Admin.new(params)

    if @admin.save
      @admin.rel_domain_ids = domains
      redirect_to admins_path, notice: 'Admin was successfully created.'
    else
      @domains = Domain.all
      render action: 'new'
    end
  end

  def edit
    @domains = Domain.all
  end

  def update
    params = admin_params.dup
    domains = params["domains"]
    params.delete("domains")

    if @admin.update(params)
      @admin.rel_domain_ids = domains
      redirect_to admins_path, notice: 'Admin was successfully updated.'
    else
      @domains = Domain.all
      render action: 'edit'
    end
  end

  def destroy
    raise "Invalid action" if @admin == @current_admin
    @admin.destroy
    redirect_to admins_path
  end

  private

  def super_admin_check
    raise "Ivalid admin access" unless @current_admin.super_admin?
  end

  def set_admin
    @admin = Admin.find(params[:id])
    raise "Invalid admin access" unless @current_admin.has_admin?(@admin)
  end

  def admin_params
    params.require(:admin).permit(:username, :password_plain,
                                  :password_plain_confirmation,
                                  :active, domains: [])
  end
end
