module ApplicationHelper
  def default_meta_tags
    {
      site: 'Flashare',
      title: 'フラッシュカードを作成してシェアできるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Flashareはカードを作成・解答して、作成したデッキを任意で公開できるフラッシュカードアプリです。',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@karume_Ao',
      }
    }
  end
end