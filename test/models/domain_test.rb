require 'test_helper'

# ExistingTimestamp (created/modified カラム) のカナリアテスト
# AR の private API に依存しているため Rails アップグレードで壊れたら検知する
class DomainTest < ActiveSupport::TestCase
  # created/modified には DB カラムデフォルト '2000-01-01 00:00:00' があるため
  # AR 標準のタイムスタンプ設定はスキップされ, ExistingTimestamp の before_create が設定する
  test "create sets created and modified" do
    now = Time.zone.parse("2024-05-01 12:00:00")
    travel_to now do
      domain = Domain.create!(domain: "timestamp.example", description: "",
                              aliases: 0, mailboxes: 0, maxquota: 0)
      domain.reload
      assert_equal now, domain.created
      assert_equal now, domain.modified
    end
  end

  test "create keeps explicitly assigned created" do
    explicit = Time.zone.parse("2010-06-15 00:00:00")
    domain = Domain.create!(domain: "explicit.example", description: "",
                            aliases: 0, mailboxes: 0, maxquota: 0,
                            created: explicit)
    assert_equal explicit, domain.reload.created
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
