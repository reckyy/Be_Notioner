module ApplicationHelper
  def default_meta_tags
    {
      site: 'Be Notioner',
      title: 'Notionとともに1日を生きよう。',
      reverse: 'false',
      description: 'Be Notionerは、「Notionを使ってみたいけど何からしたらいいかわからない」方にNotionのテンプレートなどを提供するサービスです。',
      keywords: '効率化,Notion,タスク,テンプレート,プログラミング,インプット',
      canonical: request.original_url,
      separator: '|',
      #icon: [],
      og: {
        site_name: :site,
        title: :full_title,#:full_titleはサイトに表示される<title>と同一のものを表示
        description: :description,
        type: 'website',
        url: request.original_url,
        #image: image_url(),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@recky4711692',
      }
    }
  end
end
