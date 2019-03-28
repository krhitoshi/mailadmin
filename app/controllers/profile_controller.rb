class ProfileController < ApplicationController

  def update
    if profile_params[:password_unencrypted].blank?
      @current_admin.password = nil
    end

    if @current_admin.update(profile_params)
      flash[:notice] = 'Your password was successfully updated.'
    end

    render "edit"
  end

  private

  def profile_params
    params.require(:admin).permit(:password_unencrypted,
                                  :password_unencrypted_confirmation)
  end
end
