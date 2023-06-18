class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.text :detail
      t.string :thumbnail, null: false
      t.integer :view_count, null: false
      t.string :youtube_id, null: false

      t.timestamps
    end
  end
end
