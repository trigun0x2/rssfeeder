require 'sinatra'
require 'simple-rss'
require 'open-uri'
require 'slim'
require 'sequel'
require 'json'

before do 
     DB = Sequel.sqlite('feed.db') 
end

get '/' do
  @rss = SimpleRSS.parse open('http://feeds.feedburner.com/PoorlyDrawnLines')
  @favs = DB[:feed_fav]
  slim :index
end

post '/api/fav' do
  fav = DB[:feed_fav]
  fav.insert(link: params["link"], title: params["title"])
  params["title"]
end
