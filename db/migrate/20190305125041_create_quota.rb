class CreateQuota < ActiveRecord::Migration[5.2]
  def change
    create_table :quota do |t|

      t.timestamps
    end
  end
end
