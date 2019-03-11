class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  validates :address, presence: true, uniqueness: true
  validates :goto, presence: true

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
end
