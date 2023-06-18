class QiitaArticlesController < ApplicationController
  require 'json'

  def get
    base_url = 'https://qiita.com'
    connection = Faraday.new(url: base_url)
    all_articles = []

    #現在Notionタグの記事数が342件のため、（6/18時点）4ページのみ取得
    (1..4).each do |page_number|
      response = connection.get do |req|
        req.url 'api/v2/tags/Notion/items'
        req.params['page'] = page_number
        req.params['per_page'] = 100 #1ページあたり最大100項目
      end

      json = JSON.parse(response.body)
      articles = json.map do |item|
        { title: item['title'], url: item['url'], likes_count: item['likes_count'] }
      end
      all_articles += articles
    end

    all_articles.sort_by { |i| i[:likes_count]}.reverse.take(20)
  end
end
