class AliasesController < ApplicationController
  before_action :set_alias, only: [:edit, :update, :destroy]
  before_action :set_domain, only: [:index, :new, :create]

  def new
    @alias = Alias.new
  end

  def create
    @alias = Alias.new
    @alias.rel_domain = @domain
    # rel_domain must be set in advance
    @alias.assign_attributes(alias_params)

    if @alias.save
      redirect_to domain_aliases_path(@alias.domain), notice: 'Alias was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    unless @alias.address.nil?
      @alias.local_part = @alias.address.split("@").first
    end
  end

  def update
    if @alias.update(alias_params)
      redirect_to domain_aliases_path(@alias.domain), notice: 'Alias was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @alias.destroy
    redirect_to domain_aliases_path(@alias.domain)
  end

  private

  def set_domain
    @domain = Domain.find(params[:domain_id])
    raise "Invalid domain access" unless @current_admin.has_domain?(@domain)
  end

  def set_alias
    @alias = Alias.find(params[:id])
    set_domain
    raise "Invalid Paramters" if @alias.rel_domain != @domain
  end

  def alias_params
    params.require(:alias).permit(:local_part, :active, forward_addresses: [])
  end
end
