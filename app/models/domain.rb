class Domain < ApplicationRecord
  self.table_name = :domain
  self.primary_key = :domain

  has_many :rel_mailboxes, class_name: "Mailbox", foreign_key: :domain
  has_many :rel_aliases, class_name: "Alias", foreign_key: :domain

  def pure_aliases
    rel_aliases.pure
  end
end
