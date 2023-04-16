class CreateShortcuts < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcuts do |t|
      t.string :title, null: false
      t.string :keys, null: false
      t.timestamps
    end
    add_index :shortcuts, :keys, unique: true
  end
end
