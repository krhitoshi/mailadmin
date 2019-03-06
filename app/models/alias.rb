class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address

  belongs_to :rel_domain, class_name: "Domain", foreign_key: :domain
end
