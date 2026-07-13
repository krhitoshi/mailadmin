require 'test_helper'

# ExistingTimestamp (created/modified カラム) のカナリアテスト
# AR の private API に依存しているため Rails アップグレードで壊れたら検知する
class DomainTest < ActiveSupport::TestCase
  # 既存挙動: created/modified には DB デフォルト '2000-01-01 00:00:00' があり,
  # AR は新規レコードにカラムデフォルトを読み込むため attribute_present? が true になり
  # create 時のタイムスタンプ設定はスキップされる (update 時の modified は設定される)
  test "create leaves created and modified at column default" do
    domain = Domain.create!(domain: "timestamp.example", description: "",
                            aliases: 0, mailboxes: 0, maxquota: 0)
    domain.reload
    assert_equal "2000-01-01", domain.created.strftime("%Y-%m-%d")
    assert_equal "2000-01-01", domain.modified.strftime("%Y-%m-%d")
  end

  test "update advances modified" do
    domain = domains(:example)
    original = domain.modified

    travel 1.hour do
      domain.update!(description: "Updated")
    end

    assert_operator domain.reload.modified, :>, original
  end
end
