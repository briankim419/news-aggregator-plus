require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'csv'
require_relative 'models/articles.rb'


# (only if we have a class) require_relative 'models/my_class.rb'
set :bind, '0.0.0.0'

get "/articles" do
  @articles = []
  CSV.foreach('articles.csv', headers:true) do |row|
  @articles << Articles.new(row["article_title"], row["url"], row["description"])
  end
  erb :index
end

get "/articles/new" do
  erb :new
end

post "/articles/new" do
  article_title = params["article_title"]
  url = params["url"]
  description = params["description"]

  if article_title.empty? || url.empty? || description.empty?
    redirect "/articles/new"
  # elsif !url.downcase.include?("http://") || !url.downcase.include?("https://")
  #   redirect "/articles/new"
  else
    CSV.open("articles.csv", "a") do |csv|
      csv << [article_title, url, description]
    end
    redirect "/articles"
  end
end
