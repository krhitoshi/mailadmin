class Mailbox < ApplicationRecord
  self.table_name = :mailbox
  self.primary_key = :username

  include DovecotCramMD5Password

  attribute :quota_mb, :integer

  validates :username, presence: true, uniqueness: true,
            format: { with: RE_EMAIL_LIKE_WITH_ANCHORS,
                      message: "must be a valid email address" }
  validates :maildir, presence: true, uniqueness: true
  validates :local_part, presence: true
  validates :quota, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quota_mb, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  has_one :alias, foreign_key: :address, dependent: :destroy

  validate on: :create do |mailbox|
    domain = mailbox.rel_domain
    if !domain.mailboxes.zero? && domain.rel_mailboxes.count >= domain.mailboxes
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

  validate do |mailbox|
    domain = mailbox.rel_domain
    unless domain.maxquota.zero?
      if mailbox.quota_mb.zero?
        mailbox.errors.add(:quota_mb, "cannot be 0")
      elsif mailbox.quota_mb > domain.maxquota
        message = "must be less than or equal to #{domain.maxquota} (MB)"
        mailbox.errors.add(:quota_mb, message)
      end
    end
  end

  before_validation do |mailbox|
    mailbox.name = "" if mailbox.name.nil?
    if mailbox.quota_mb.nil?
      mailbox.quota = nil
    else
      mailbox.quota = mailbox.quota_mb * 1_024_000
    end
    mailbox.username = "#{mailbox.local_part}@#{mailbox.domain}"
    mailbox.maildir = "#{mailbox.domain}/#{mailbox.username}/"
    mailbox.build_alias(goto: mailbox.username, domain: mailbox.domain)
  end

  def quota_str
    if quota.zero?
      "Unlimited"
    else
      quota_mb = quota / 1_024_000
      "#{quota_mb} MB"
    end
  end
end
