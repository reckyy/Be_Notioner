class CreateQiitaArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :qiita_articles do |t|
      t.string :title
      t.string :url
      t.integer :likes_count

      t.timestamps
    end
  end
end
