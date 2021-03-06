class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update, :destroy]
  before_action :set_active_domain, only: [:index, :new, :create]

  def new
    @mailbox = Mailbox.new
    @mailbox.quota_mb = if @domain.maxquota.zero?
                          0
                        else
                          @domain.maxquota
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
    unless @mailbox.quota.nil?
      @mailbox.quota_mb = (@mailbox.quota / 1_024_000).to_i
    end
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

  def set_mailbox
    @mailbox = Mailbox.find(params[:id])
    set_active_domain
    raise "Invalid Paramters" if @mailbox.rel_domain != @domain
  end

  def mailbox_params
    params.require(:mailbox).permit(:local_part, :name, :password_unencrypted,
                                    :password_unencrypted_confirmation,
                                    :quota_mb, :active)
  end
end
