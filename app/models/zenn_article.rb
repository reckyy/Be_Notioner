class ZennArticle < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :likes_count
  validates :order_type, presence: true

  has_one :ogp_information, as: :informable, dependent: :destroy

  require 'nokogiri'
  require 'open-uri'

  TOPIC_URLS = {
    "alltime" => "https://zenn.dev/topics/notion?order=alltime",
    "latest" => "https://zenn.dev/topics/notion?order=latest"
  }

  def self.fetch_and_save_articles!
    TOPIC_URLS.each do |order_type, topic_url|
      topic_doc = Nokogiri::HTML(open(topic_url))
      articles = topic_doc.css('.ArticleList_itemLink').take(15)

      articles.each do |article|
        title = article.at_css('.ArticleList_title').text.strip
        url = "https://zenn.dev#{article['href']}"
        likes_count_raw = article.at_css('.ArticleList_like')
        likes_count = likes_count_raw.nil? ? 0 : likes_count_raw.text.strip.gsub(/\D/, '')

        zenn_article = find_or_initialize_by(url: url) do |za|
          za.title = title
          za.likes_count = likes_count
          za.order_type = order_type
        end
        zenn_article.save!
        zenn_article.fetch_and_save_ogp_info!
      end
    end
  end

  def fetch_and_save_ogp_info!
    doc = Nokogiri::HTML(open(url))
    ogp_info = build_ogp_information unless ogp_information
    ogp_info.title = doc.xpath('/html/head/meta[@property="og:title"]/@content').to_s
    ogp_info.url = doc.xpath('/html/head/meta[@property="og:url"]/@content').to_s
    ogp_info.image = doc.xpath('/html/head/meta[@property="og:image"]/@content').to_s
    ogp_info.description = doc.xpath('/html/head/meta[@property="og:description"]/@content').to_s
    ogp_info.save!
  end
end

end
