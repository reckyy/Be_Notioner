class QiitaArticlesController < ApplicationController
  def index
    @popular_articles = QiitaArticle.order(likes_count: :desc).limit(20)
    @recent_articles = QiitaArticle.order(created_at_qiita: :desc).limit(20)
  end
end
