class Domain < ApplicationRecord
  self.table_name = :domain
  self.primary_key = :domain

  validates :domain, presence: true, uniqueness: true,
            format: { with: RE_DOMAIN_NAME_LIKE, message: "must be a valid domain name" }

  has_many :rel_mailboxes, class_name: "Mailbox", foreign_key: :domain,
           dependent: :destroy
  has_many :rel_aliases, class_name: "Alias", foreign_key: :domain,
           dependent: :destroy

  before_validation do |domain|
    domain.domain = domain.domain.downcase unless domain.domain.empty?
  end

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
