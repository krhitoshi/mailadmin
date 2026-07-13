# Initial data for manual testing
# The ALL domain row is inserted by db/structure.sql

admin = Admin.find_or_initialize_by(username: "admin@example.com")
admin.password_unencrypted = "adminpass"
admin.password_unencrypted_confirmation = "adminpass"
admin.active = true
admin.save!

DomainAdmin.find_or_create_by!(username: "admin@example.com", domain: "ALL")
