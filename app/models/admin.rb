class Admin < ApplicationRecord
  self.table_name = :admin
  self.primary_key = :username

  include DovecotCramMD5Password

  validates :username, presence: true, uniqueness: true,
            format: { with: RE_EMAIL_LIKE, message: "must be a valid email address" }

  has_many :domain_admins, foreign_key: :username, dependent: :delete_all
  has_many :rel_domains, through: :domain_admins

  scope :active, -> { where(active: true) }

  attr_accessor :domain_ids

  # just in case
  validate on: :update do |admin|
    admin.errors.add(:username, 'cannot be changed') if admin.username_changed?
  end


  def super_admin?
    rel_domains.exists?("ALL")
  end

  def has_admin?(admin)
    self == admin || super_admin?
  end

  def has_domain?(domain)
    !rel_domains.where(domain: ["ALL", domain.domain]).empty?
  end
end
