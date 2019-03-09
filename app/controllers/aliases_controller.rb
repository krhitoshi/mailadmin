class AliasesController < ApplicationController
  before_action :set_alias, only: [:edit, :update, :destroy]
  before_action :set_domain, only: [:new, :edit]

  def new
    @alias = Alias.new
    @alias.rel_domain = @domain
  end

  def create
    @alias = Alias.new(alias_params)

    if @alias.save
      redirect_to domain_path(@alias.domain), notice: 'Alias was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @alias.update(alias_params)
      redirect_to domain_path(@alias.domain), notice: 'Alias was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @alias.destroy
    redirect_to domain_path(@alias.domain)
  end

  private

  def set_domain
    @domain = Domain.find(params[:domain_id])
  end

  def set_alias
    @alias = Alias.find(params[:id])
  end

  def alias_params
    params.require(:alias).permit(:address, :domain, :goto, :active)
  end
end
