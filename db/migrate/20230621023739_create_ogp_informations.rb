class CreateOgpInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :ogp_informations do |t|

      t.string :title, null: false
      t.string :url, null: false
      t.string :image, null: false
      t.string :description, null: false
      t.string :informable_type, null: false
      t.integer :informable_id, null: false

      t.timestamps
    end
    add_index :ogp_informations, [:informable_type, :informable_id]
  end
end
