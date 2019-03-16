class AdminsController < ApplicationController
  before_action :super_admin_check, only: [:new, :create, :destroy]
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    if @current_admin.super_admin?
      @admins = Admin.all
    else
      @admins = [@current_admin]
    end
  end

  def new
    @admin = Admin.new
    @domains = Domain.without_all.all
  end

  def create
    @admin = Admin.new(admin_params)

    # transation for InnoDB
    Admin.transaction do
      @admin.save!
      domain_ids = admin_params["domain_ids"].dup
      domain_ids << "ALL" if @admin.form_super_admin
      @admin.rel_domain_ids = domain_ids
    end

    redirect_to admins_path, notice: 'Admin was successfully created.'

  rescue ActiveRecord::ActiveRecordError => e
    logger.error("#{e.class}: #{e}")
    flash[:notice] = "Failed to save Admin"
    @domains = Domain.all
    render action: 'new'
  end

  def edit
    @domains = Domain.without_all.all
    @admin.domain_ids = @admin.rel_domains.map(&:domain)
    @admin.form_super_admin = @admin.super_admin?
  end

  def update
    # transation for InnoDB
    Admin.transaction do
      @admin.update!(admin_params)
      domain_ids = admin_params["domain_ids"].dup
      domain_ids << "ALL" if @admin.form_super_admin
      @admin.rel_domain_ids = domain_ids
    end

    redirect_to admins_path, notice: 'Admin was successfully updated.'

  rescue ActiveRecord::ActiveRecordError => e
    logger.error("#{e.class}: #{e}")
    flash[:notice] = "Failed to save Admin"
    @domains = Domain.all
    render action: 'edit'
  end

  def destroy
    raise "Invalid action" if @admin == @current_admin
    @admin.destroy
    redirect_to admins_path
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
    raise "Invalid admin access" unless @current_admin.has_admin?(@admin)
  end

  def admin_params
    params.require(:admin).permit(:username, :password_unencrypted,
                                  :password_unencrypted_confirmation,
                                  :active, :form_super_admin, domain_ids: [])
  end
end
