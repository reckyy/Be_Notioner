class QiitaArticlesController < ApplicationController
  require 'json'
  require 'open-uri' #URLへアクセスするようライブラリ
  require 'nokogiri' #取得したURLをスクレイピング

  BASE_URL = 'https://qiita.com'

  def popular
    @popular_articles = order_of_popularity
  end

  def order_of_popularity
    popular_articles = get_articles
    ogp_info = popular_articles.map do |article|
      fetch_ogp(article[:url])
    end
    #両方のhashを返す
    {popular_articles: popular_articles, ogp_info: ogp_info}
  end

  def get_articles
    connection = Faraday.new(url: BASE_URL)
    all_articles = []

    #現在Notionタグの記事数が342件のため、（6/18時点）4ページのみ取得
    (1..2).each do |page_number|
      articles = fetch_articles(connection, page_number)
      all_articles.concat(articles)
    end

    all_articles.sort_by { |i| i[:likes_count]}.reverse.take(20)
  end

  def fetch_articles(connection, page_number)
    response = connection.get do |req|
      req.url 'api/v2/tags/Notion/items'
      req.params['page'] = page_number
      req.params['per_page'] = 100 #1ページあたり最大100項目
    end

    json = JSON.parse(response.body)
    json.map do |item|
      { title: item['title'], url: item['url'], likes_count: item['likes_count'] }
    end
  end

  #取得したurlのHTMLを解析するメソッド
  def fetch_ogp(url)
    charset = nil
    html = URI.open(url) do |f| #open関数がローカルのファイルパスとみなすため、URI.openに変更
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    extract_ogp_info(doc)
  end

  #HTMLのOGPを抜き出すメソッド
  def extract_ogp_info(doc)
    ogp_title = doc.xpath('/html/head/meta[@property="og:title"]/@content').to_s
    ogp_url = doc.xpath('/html/head/meta[@property="og:url"]/@content').to_s
    ogp_image = doc.xpath('/html/head/meta[@property="og:image"]/@content').to_s
    ogp_description = doc.xpath('/html/head/meta[@property="og:description"]/@content').to_s  

    { title: ogp_title, url: ogp_url, image: ogp_image, description: ogp_description }
  end

end
