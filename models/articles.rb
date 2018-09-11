class Articles
  attr_reader :article_title, :url, :description
  def initialize(article_title, url, description)
    @article_title = article_title
    @url = url
    @description = description
  end
end
