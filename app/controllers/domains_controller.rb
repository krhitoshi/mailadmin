class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update]

  def index
    @domains = Domain.all
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

  private

  def set_domain
    @domain = Domain.find(params[:id])
  end

  def domain_params
    params.require(:domain).permit(:description, :aliases, :mailboxes, :active)
  end
end
