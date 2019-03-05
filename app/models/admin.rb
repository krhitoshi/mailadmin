class Admin < ApplicationRecord
  self.table_name = :admin
  self.primary_key = :username
end
