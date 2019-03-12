class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include ExistingTimestamp

  RE_DOMAIN_NAME_LIKE = /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/
  RE_EMAIL_LIKE = /[^@\s]+@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/
end
