class AddCreatedAtQiitaToQiitaArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :qiita_articles, :created_at_qiita, :datetime
  end
end
