class QiitaArticlesController < ApplicationController
  def index
    @popular_articles = QiitaArticle.order(likes_count: :desc).limit(20)
    respond_to do |format|
      format.html
      format.js
    end
    @popular_articles = QiitaArticle.where("created_at >= ?", 1.week.ago).order(likes_count: :desc).limit(20)
  end
end
