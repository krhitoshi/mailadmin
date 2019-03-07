class DomainAdmin < ApplicationRecord
  self.table_name = :domain_admins

  has_one :domain, primary_key: :domain, foreign_key: :domain

  def self.timestamp_attributes_for_create
    ["created"]
  end
  private_class_method :timestamp_attributes_for_create
end
