Sequel.migration do
  up do
    create_table :feed_fav do
      primary_key :id
      String :link
      String :title
      unique [:link, :title]
    end
  end

  down do
    drop_table(:feed_fav)
  end
end
