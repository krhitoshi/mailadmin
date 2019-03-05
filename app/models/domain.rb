class Domain < ApplicationRecord
  self.table_name = :domain
  self.primary_key = :domain

  has_many :rel_mailboxes, class_name: "Mailbox", foreign_key: :domain
end
