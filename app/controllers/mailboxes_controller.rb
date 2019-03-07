class MailboxesController < ApplicationController
  before_action :set_mailbox, only: [:edit, :update]
  before_action :set_domain, only: [:new]

  def new
    @mailbox = Mailbox.new
    @mailbox.rel_domain = @domain
  end

  def create
    params = mailbox_params.dup

    if params["password"] != params["password_confirmation"]
      params.delete("password_confirmation")
      @mailbox = Mailbox.new(params)
      flash[:notice] = "Password mismatch"
      render action: 'new'
      return
    end

    params["password"] = DovecotCrammd5.calc(params["password"])
    params.delete("password_confirmation")
    @mailbox = Mailbox.new(params)

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

  def set_domain
    @domain = Domain.find(params[:domain_id])
  end

  def set_mailbox
    @mailbox = Mailbox.find(params[:id])
  end

  def mailbox_params
    params.require(:mailbox).permit(:username, :name, :domain, :password, :password_confirmation, :quota, :active)
  end
end
