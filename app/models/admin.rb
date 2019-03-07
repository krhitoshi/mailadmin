class Admin < ApplicationRecord
  self.table_name = :admin
  self.primary_key = :username

  has_many :domain_admins, foreign_key: :username
  has_many :domains, through: :domain_admins

  def self.timestamp_attributes_for_create
    ["created"]
  end
  private_class_method :timestamp_attributes_for_create

  def self.timestamp_attributes_for_update
    ["modified"]
  end
  private_class_method :timestamp_attributes_for_update
end
