class Domain < ApplicationRecord
  self.table_name = :domain
  self.primary_key = :domain

  has_many :rel_mailboxes, class_name: "Mailbox", foreign_key: :domain,
           dependent: :destroy
  has_many :rel_aliases, class_name: "Alias", foreign_key: :domain,
           dependent: :destroy

  scope :without_all, -> { where.not(domain: "ALL") }

  def pure_aliases
    rel_aliases.pure
  end

  def maxquota_str
    if maxquota.zero?
      "Unlimited"
    else
      maxquota.to_s
    end
  end
end
