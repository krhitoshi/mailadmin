class Admin < ApplicationRecord
  self.table_name = :admin
  self.primary_key = :username

  validates :username, presence: true, uniqueness: true
  validates :password_plain, length: { minimum: 5 }, allow_blank: true
  validates_confirmation_of :password_plain, allow_blank: true

  validate do |record|
    record.errors.add(:password_plain, :blank) unless record.password.present?
  end

  has_many :domain_admins, foreign_key: :username, dependent: :delete_all
  has_many :rel_domains, through: :domain_admins

  scope :active, -> { where(active: true) }

  attr_accessor :domain_ids

  attr_reader :password_plain
  attr_accessor :password_plain_confirmation

  def password_plain=(unencrypted_password)
    if unencrypted_password.nil?
      self.password = nil
    elsif !unencrypted_password.empty?
      @password_plain = unencrypted_password
      self.password = DovecotCrammd5.calc(unencrypted_password)
    end
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

  def authenticate(unencrypted_password)
    password == DovecotCrammd5.calc(unencrypted_password)
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
