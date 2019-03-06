class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update]

  def edit
  end

  def update
    params = mailbox_params.dup
    if params["password"]
      params["password"] = DovecotCrammd5.calc(params["password"])
    end
    logger.debug("prams: #{params}")
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
    params.require(:mailbox).permit(:name, :password, :quota, :active)
  end
end
