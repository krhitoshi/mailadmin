class AliasesController < ApplicationController
  before_action :set_alias, only: [:edit, :update]

  def edit
  end

  def update
    if @alias.update(alias_params)
      redirect_to domain_path(@alias.domain), notice: 'Alias was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  def set_alias
    @alias = Alias.find(params[:id])
  end

  def alias_params
    params.require(:alias).permit(:goto, :active)
  end
end
