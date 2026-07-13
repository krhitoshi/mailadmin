require 'test_helper'

# Canary tests for ExistingTimestamp (created/modified columns)
# It depends on private AR API, so these detect breakage on Rails upgrades
class DomainTest < ActiveSupport::TestCase
  # created/modified have the DB column default '2000-01-01 00:00:00', so
  # AR skips its own stamping and the before_create in ExistingTimestamp sets them
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
