require 'active_support/concern'

module ExistingTimestamp
  extend ActiveSupport::Concern

  included do
    # created/modified には DB カラムデフォルト '2000-01-01 00:00:00' があり,
    # AR がデフォルト値を設定済み属性とみなして create 時のタイムスタンプ設定を
    # スキップするため, 明示的に値が代入されていない場合はここで設定する
    # (domain_admins には modified が, quota2 には両方が無いため has_attribute? で確認)
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
