class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  validates :address, presence: true, uniqueness: true
  validates :goto, presence: true

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
  belongs_to :mailbox, foreign_key: :address, optional: true

  scope :pure, -> { joins("LEFT OUTER JOIN mailbox ON alias.address = mailbox.username").where("mailbox.username" => nil) }

  def local_part
    if self.address.present?
      @loca_part, _ = self.address.split("@")
    end
    @loca_part
  end

  def local_part=(input_local_part)
    if input_local_part.nil?
      self.address = nil
    elsif !input_local_part.empty?
      @local_part = input_local_part
      raise "Domain is not specified for Alias" unless self.domain.present?
      self.address = "#{input_local_part}@#{self.domain}"
    end
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
