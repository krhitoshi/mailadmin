require 'active_support/concern'

module ExistingTimestamp
  extend ActiveSupport::Concern

  included do
    # created/modified have the DB column default '2000-01-01 00:00:00' and
    # AR treats the loaded default as a user-set attribute and skips its own
    # timestamp stamping on create, so set them here unless explicitly assigned
    # (checked with has_attribute? since domain_admins has no modified and
    # quota2 has neither)
    before_create do
      now = Time.current
      if has_attribute?(:created) && !created_changed?
        self.created = now
      end
      if has_attribute?(:modified) && !modified_changed?
        self.modified = now
      end
    end
  end

  class_methods do
    private

    def timestamp_attributes_for_create
      ["created"]
    end

    def timestamp_attributes_for_update
      ["modified"]
    end
  end

end
