class CreateDomainAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_admins do |t|

      t.timestamps
    end
  end
end
