# 手動確認用の初期データ
# ALL ドメイン行は db/structure.sql の INSERT で投入済み

admin = Admin.find_or_initialize_by(username: "admin@example.com")
admin.password_unencrypted = "adminpass"
admin.password_unencrypted_confirmation = "adminpass"
admin.active = true
admin.save!

DomainAdmin.find_or_create_by!(username: "admin@example.com", domain: "ALL")
