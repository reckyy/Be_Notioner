class FetchAndSaveArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    QiitaArticle.fetch_and_save_articles!
  end
end
