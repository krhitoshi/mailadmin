class DomainAdmin < ApplicationRecord
  self.table_name = :domain_admins

  belongs_to :admin, primary_key: :username, foreign_key: :username
  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain

  def self.timestamp_attributes_for_create
    ["created"]
  end
  private_class_method :timestamp_attributes_for_create
end
