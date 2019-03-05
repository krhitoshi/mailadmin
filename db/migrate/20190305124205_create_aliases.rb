class CreateAliases < ActiveRecord::Migration[5.2]
  def change
    create_table :aliases do |t|

      t.timestamps
    end
  end
end
