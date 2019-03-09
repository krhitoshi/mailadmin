class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  def index
    if @current_admin.super_admin?
      @domains = Domain.all
    else
      @domains = @current_admin.rel_domains
    end
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(domain_params)
    @domain.transport = "virtual"

    if @domain.save
      redirect_to domain_path(@domain.domain), notice: 'Domain was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @domain.update(domain_params)
      redirect_to domains_path, notice: 'Domain was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @domain.destroy
    redirect_to domains_path
  end

  private

  def set_domain
    @domain = Domain.find(params[:id])
  end

  def domain_params
    params.require(:domain).permit(:domain, :description, :maxquota, :aliases,
                                   :mailboxes, :active)
  end
end
