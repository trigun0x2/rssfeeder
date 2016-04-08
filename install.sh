rm -f feed.db feed_test.db
echo "Installing Gems"
bundle install > /dev/null 2>&1

# Create DB and migrate
echo "Creating and migrating DB"
touch feed.db
touch feed_test.db
rake db:migrate_all

echo "\033[33;32mInstallation complete, starting server\033[0m"
shotgun
