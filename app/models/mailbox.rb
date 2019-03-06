class Mailbox < ApplicationRecord
  self.table_name = :mailbox
  self.primary_key = :username

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
end