class ZennArticlesController < ApplicationController
  def index
    @latest_articles = ZennArticle.where(order_type: 'latest')
    @alltime_articles = ZennArticle.where(order_type: 'alltime')
  end
end
