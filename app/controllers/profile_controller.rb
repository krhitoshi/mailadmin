class ProfileController < ApplicationController

  def update
    if profile_params[:password_unencrypted].blank?
      @current_admin.password = nil
    end

    # Turbo does not accept a 200 render for a form submission
    if @current_admin.update(profile_params)
      redirect_to profile_path, notice: 'Your password was successfully updated.'
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:admin).permit(:password_unencrypted,
                                  :password_unencrypted_confirmation)
  end
end
