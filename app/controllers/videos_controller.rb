class VideosController < ApplicationController
  require 'google/apis/youtube_v3'

  Youtube = Google::Apis::YoutubeV3::YouTubeService.new
  Youtube.key = ENV['GOOGLE_API_KEY']

  def search_videos
    options = {
      q: "Notion",
      type: 'video',
      max_results: 2,
      order: :date,
      region_code: 'JP',
      relevance_language: 'ja',
    }
    Youtube.list_searches(:snippet, **options)#:snippetではエラー。一つの引数しか受け付けていない。
  end

  def index
    @youtube_videos = search_videos
  end

end
