class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  validate on: :create do |a|
    domain = a.rel_domain
    if domain.rel_aliases.pure.count >= domain.aliases
      message = "already has the maximum number of aliases " \
                "(maximum is #{domain.aliases} aliases)"
      a.errors.add(:domain, message)
    end
  end

  # TODO: Validation of address format
  validates :address, presence: true, uniqueness: true
  validates :goto, presence: true

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  belongs_to :mailbox, foreign_key: :address, optional: true

  scope :pure, -> { joins("LEFT OUTER JOIN mailbox ON alias.address = mailbox.username").where("mailbox.username" => nil) }

  attr_accessor :local_part

  def local_part
    unless self.address.nil?
      @local_part, _ = self.address.split("@")
    end
    @local_part
  end

  before_validation do |a|
    a.address = "#{a.local_part}@#{a.domain}" unless a.local_part.empty?
  end

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
