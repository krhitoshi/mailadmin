class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  belongs_to :mailbox, foreign_key: :address, optional: true

  scope :pure, -> { joins("LEFT OUTER JOIN mailbox ON alias.address = mailbox.username").where("mailbox.username" => nil) }

  def mailbox?
    !!mailbox
  end

  def pure_alias?
    !mailbox
  end

  def gotos
    goto.split(",")
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
