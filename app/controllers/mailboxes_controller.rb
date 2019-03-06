class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update]

  def edit
  end

  def update
    if @mailbox.update(mailbox_params)
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
    params.require(:mailbox).permit(:name, :quota, :active)
  end
end
