class Mailbox < ApplicationRecord
  self.table_name = :mailbox
  self.primary_key = :username

  include DovecotCramMD5Password

  validates :username, presence: true, uniqueness: true,
            format: { with: RE_EMAIL_LIKE, message: "must be a valid email address" }
  validates :maildir, presence: true, uniqueness: true
  validates :local_part, presence: true

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  has_one :alias, foreign_key: :address, dependent: :destroy

  validate on: :create do |mailbox|
    domain = mailbox.rel_domain
    if domain.rel_mailboxes.count >= domain.mailboxes
      message = "already has the maximum number of mailboxes " \
                "(maximum is #{domain.mailboxes} mailboxes)"
      mailbox.errors.add(:domain, message)
    end
  end

  # just in case
  validate on: :update do |mailbox|
    mailbox.errors.add(:username, 'cannot be changed') if mailbox.username_changed?
    mailbox.errors.add(:local_part, 'cannot be changed') if mailbox.local_part_changed?
  end

  before_validation do |mailbox|
    mailbox.name = "" if mailbox.name.nil?
    mailbox.username = "#{mailbox.local_part}@#{mailbox.domain}"
    mailbox.maildir = "#{mailbox.domain}/#{mailbox.username}/"
    mailbox.build_alias(goto: mailbox.username, domain: mailbox.domain)
  end

  def quota_str
    if quota.zero?
      "Unlimited"
    else
      (quota / 1_024_000).to_s
    end
  end
end
