require 'sinatra'
require 'simple-rss'
require 'open-uri'
require 'slim'
require 'sequel'
require 'json'

before do
  if ENV['RACK_ENV'] != 'test'
    DB = Sequel.connect(ENV['DATABASE_URL'] || "sqlite://feed.db")
  else
    DB = Sequel.connect("sqlite://feed_test.db")
  end
end

get '/' do
  @rss = SimpleRSS.parse open('http://feeds.feedburner.com/PoorlyDrawnLines')
  @favs = DB[:feed_fav]
  slim :index
end

post '/api/fav' do
  content_type :json
  fav = DB[:feed_fav]
  begin
    fav.insert(link: params["link"], title: params["title"])
  rescue
    [400, { message: "Could not save article" }.to_json]
  else
    # This should return the actual object
    [200, { message: "Article saved" }.to_json]
  end
end

delete '/api/fav' do
  content_type :json
  fav = DB[:feed_fav]
  begin
    fav.where(title: params["title"], link: params[:link]).delete
  rescue
    [400, { message: "Could not unsave article" }.to_json]
  else
    # This should return the actual object
    [200, { message: "Article unsaved" }.to_json]
  end

end
