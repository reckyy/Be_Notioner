class VideosController < ApplicationController
  require 'google/apis/youtube_v3'

  Youtube = Google::Apis::YoutubeV3::YouTubeService.new
  Youtube.key = ENV['GOOGLE_API_KEY']

  def search_videos
    options = {
      q: "Notion",
      type: 'video',
      max_results: 5,
      order: :relevance,
      region_code: 'JP',
      relevance_language: 'ja',
      video_category_id: '28'#Notionのカテゴリー。
    }
    Youtube.list_searches(:snippet, **options)#:snippetではエラー。一つの引数しか受け付けていない。
    #直接list_searchesメソッドでは視聴回数を取得できないため、list_videosメソッドを別途用いる必要がある。
  end

  def index
    @youtube_videos = search_videos
  end

end
