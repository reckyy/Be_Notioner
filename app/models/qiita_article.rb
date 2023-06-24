class QiitaArticle < ApplicationRecord

  require 'json'
  require 'open-uri' #URLへアクセスするようライブラリ
  require 'nokogiri' #取得したURLをスクレイピング

  has_many :bookmarks, as: :bookmarkable

  has_one :ogp_information, as: :informable, dependent: :destroy #ポリモーフィック関連

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :likes_count, presence: true
  validates :created_at_qiita, presence: true

  BASE_URL = 'https://qiita.com'
  TAG = 'Notion'
  PAGES_TO_FETCH = 4
  PER_PAGE = 100

  def self.fetch_and_save_articles!
    connection = Faraday.new(url: BASE_URL)
    fetched_articles = []

    (1..PAGES_TO_FETCH).each do |page_number|
      response = connection.get do |req|
        req.url "api/v2/tags/#{TAG}/items"
        req.params['page'] = page_number
        req.params['per_page'] = PER_PAGE
      end

      json = JSON.parse(response.body)
      json.each do |item|
        fetched_articles << { 
          title: item['title'], 
          url: item['url'], 
          likes_count: item['likes_count'],
          created_at_qiita: item['created_at']
        }
      end
    end

    fetched_articles.each do |article_data|
      qiita_article = find_or_initialize_by(url: article_data[:url]) do |article|
        article.title = article_data[:title]
        article.likes_count = article_data[:likes_count]
        article.created_at_qiita = DateTime.parse(article_data[:created_at_qiita])
      end
      qiita_article.save!
      qiita_article.fetch_and_save_ogp_info!
    end

    ids_to_keep = fetched_articles.map { |article| article[:url] }
    where.not(url: ids_to_keep).destroy_all
  end

  def fetch_and_save_ogp_info!
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)

    ogp_info = build_ogp_information unless ogp_information
    ogp_information.title = doc.xpath('/html/head/meta[@property="og:title"]/@content').to_s
    ogp_information.url = doc.xpath('/html/head/meta[@property="og:url"]/@content').to_s
    ogp_information.image = doc.xpath('/html/head/meta[@property="og:image"]/@content').to_s
    ogp_information.description = doc.xpath('/html/head/meta[@property="og:description"]/@content').to_s
    ogp_information.save!
  end
end
