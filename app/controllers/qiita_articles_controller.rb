class QiitaArticlesController < ApplicationController
  def popular
    @popular_articles = QiitaArticle.order(likes_count: :desc).limit(20) #一応いいね順に。
  end

  def recent_popular
    @popular_articles = QiitaArticle.where("created_at >= ?", 1.week.ago).order(likes_count: :desc).limit(20)
  end
end
