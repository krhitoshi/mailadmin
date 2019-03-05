class CreateMailboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :mailboxes do |t|

      t.timestamps
    end
  end
end
