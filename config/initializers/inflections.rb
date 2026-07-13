# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

# Zeitwerk はファイル名 dovecot_cram_md5_password から DovecotCramMd5Password を
# 期待するため, 実際のモジュール名 DovecotCramMD5Password を登録する
Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect("dovecot_cram_md5_password" => "DovecotCramMD5Password")
end
