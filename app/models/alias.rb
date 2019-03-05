class Alias < ApplicationRecord
  self.table_name = :alias
  self.primary_key = :address
end
