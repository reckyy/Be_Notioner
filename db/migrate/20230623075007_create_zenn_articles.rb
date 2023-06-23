class CreateZennArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :zenn_articles do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :likes_count

      t.timestamps
    end
  end
end
