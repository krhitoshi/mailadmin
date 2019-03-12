class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update, :destroy]
  before_action :set_domain, only: [:new, :create]

  def new
    @mailbox = Mailbox.new
    @mailbox.quota = if @domain.maxquota.zero?
                       0
                     else
                       @domain.maxquota * 1_024_000
                     end
  end

  def create
    @mailbox = Mailbox.new(mailbox_params)
    @mailbox.rel_domain = @domain

    # transation for InnoDB
    Mailbox.transaction do
      @mailbox.save!
    end

    redirect_to domain_path(@mailbox.domain), notice: 'Mailbox was successfully created.'

  rescue ActiveRecord::ActiveRecordError => e
    logger.error("#{e.class}: #{e}")
    flash[:notice] = "Failed to save Mailbox"
    render action: 'new'
  end

  def edit
  end

  def update
    if @mailbox.update(mailbox_params)
      redirect_to domain_path(@mailbox.domain), notice: 'Mailbox was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @mailbox.destroy
    redirect_to domain_path(@mailbox.domain)
  end

  private

  def set_domain
    @domain = Domain.find(params[:domain_id])
    raise "Invalid domain access" unless @current_admin.has_domain?(@domain)
  end

  def set_mailbox
    @mailbox = Mailbox.find(params[:id])
    set_domain
    raise "Invalid Paramters" if @mailbox.rel_domain != @domain
  end

  def mailbox_params
    params.require(:mailbox).permit(:local_part, :name, :password_unencrypted,
                                    :password_unencrypted_confirmation,
                                    :quota, :active)
  end
end
