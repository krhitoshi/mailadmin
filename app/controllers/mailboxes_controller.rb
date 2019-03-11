class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update, :destroy]
  before_action :set_domain, only: [:new, :create]

  def new
    @mailbox = Mailbox.new
    @mailbox.rel_domain = @domain
  end

  def create
    @mailbox = Mailbox.new(mailbox_params)

    # TODO: Validation of username
    local_part, _ = @mailbox.username.split("@")
    @mailbox.maildir = "#{@mailbox.domain}/#{@mailbox.username}/"
    @mailbox.local_part  = local_part
    @mailbox.build_alias(goto: @mailbox.username, domain: @mailbox.domain)

    if @mailbox.save
      redirect_to domain_path(@mailbox.domain), notice: 'Mailbox was successfully created.'
    else
      render action: 'new'
    end
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
    params.require(:mailbox).permit(:username, :name, :domain,
                                    :password_unencrypted,
                                    :password_unencrypted_confirmation,
                                    :quota, :active)
  end
end
