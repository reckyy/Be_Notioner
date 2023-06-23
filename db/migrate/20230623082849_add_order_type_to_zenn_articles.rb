class AddOrderTypeToZennArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :zenn_articles, :order_type, :string, null: false
  end
end
