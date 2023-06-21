class CreateQiitaArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :qiita_articles do |t|

      t.timestamps
    end
  end
end
