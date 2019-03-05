class Mailbox < ApplicationRecord
  self.table_name = :mailbox
  self.primary_key = :username
end
