class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  belongs_to :mailbox, foreign_key: :address

  scope :pure, -> { joins("LEFT OUTER JOIN mailbox ON alias.address = mailbox.username").where("mailbox.username" => nil) }

  def mailbox?
    !!mailbox
  end

  def pure_alias?
    !mailbox
  end
end
