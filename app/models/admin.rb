class Admin < ApplicationRecord
  self.table_name = :admin
  self.primary_key = :username

  include DovecotCramMD5Password

  validates :username, presence: true, uniqueness: true

  has_many :domain_admins, foreign_key: :username, dependent: :delete_all
  has_many :rel_domains, through: :domain_admins

  scope :active, -> { where(active: true) }

  attr_accessor :domain_ids

  def super_admin?
    rel_domains.exists?("ALL")
  end

  def has_admin?(admin)
    self == admin || super_admin?
  end

  def has_domain?(domain)
    !rel_domains.where(domain: ["ALL", domain.domain]).empty?
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
