class VideoController < ApplicationController
  require 'google/apis/youtube_v3'

  Youtube = Google::Apis::YoutubeV3::YouTubeService.new
  Youtube.key = ENV['YOUTUBE_API_KEY']
end
