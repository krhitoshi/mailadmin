class Mailbox < ApplicationRecord
  self.table_name = :mailbox
  self.primary_key = :username

  include DovecotCramMD5Password

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  has_one :alias, foreign_key: :address, dependent: :destroy

  # just in case
  validate on: :update do |mailbox|
    mailbox.errors.add(:username, 'cannot be changed') if mailbox.username_changed?
  end

  def quota_str
    if quota.zero?
      "Unlimited"
    else
      (quota / 1_024_000).to_s
    end
  end

  def self.timestamp_attributes_for_create
    ["created"]
  end
  private_class_method :timestamp_attributes_for_create

  def self.timestamp_attributes_for_update
    ["modified"]
  end
  private_class_method :timestamp_attributes_for_update
end
