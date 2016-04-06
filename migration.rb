require 'sequel'
require 'sqlite3'

DB = Sequel.sqlite('feed.db')

DB.create_table :feed_fav do
  primary_key :id
  String :link
  String :title
  unique [:link, :title]
end
