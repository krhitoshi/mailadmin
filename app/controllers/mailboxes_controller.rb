class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update]

  def edit
  end

  def update
    params = mailbox_params.dup
    if params["password"]
      if params["password"] != params["password_confirmation"]
        params.delete("password_confirmation")
        @mailbox.attributes = params
        flash[:notice] = "Password mismatch"
        render action: 'edit'
        return
      end
      params["password"] = DovecotCrammd5.calc(params["password"])
      params.delete("password_confirmation")
    end
    if @mailbox.update(params)
      redirect_to domain_path(@mailbox.domain), notice: 'Mailbox was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  def set_mailbox
    @mailbox = Mailbox.find(params[:id])
  end

  def mailbox_params
    params.require(:mailbox).permit(:name, :password, :password_confirmation, :quota, :active)
  end
end
