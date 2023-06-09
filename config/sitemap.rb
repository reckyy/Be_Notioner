require 'aws-sdk-s3'
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://be-notioner.com"#サービスのURL
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['S3_BUCKET_NAME'],
  aws_access_key_id: ENV['ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
  aws_region: 'ap-northeast-1',
)

SitemapGenerator::Sitemap.create do
  add root_path

  add login_path

  add new_user_path

  add terms_path

  add privacy_path

  add templates_path, :changefreq => 'always'
  add shortcuts_path, :changefreq => 'never'

end
