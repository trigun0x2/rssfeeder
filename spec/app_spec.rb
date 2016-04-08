require File.expand_path '../spec_helper.rb', __FILE__
require 'database_cleaner'
DatabaseCleaner.strategy = :transaction

describe "RSS Feeder" do
  it "should load the homepage" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should save articles" do
    post '/api/fav', {link: "potato.com", title: "a potato"}
    expect(last_response.body).to include("Article saved")
  end

  it "shouldn't save an article more than once" do
    # DB Cleaner is iffy...
    DatabaseCleaner[:DB].start
    post '/api/fav', {link: "potato.com", title: "a potato"}
    post '/api/fav', {link: "potato.com", title: "a potato"}
    expect(last_response.body).to include("Could not save article")
    DatabaseCleaner[:DB].clean
  end

  it "should delete an article" do
    DB[:feed_fav].insert(title: "test book", link: "google.com")
    delete '/api/fav', {title: "test book", link: "google.com"}

    expect(last_response.body).to include("Article unsaved")
  end
end
