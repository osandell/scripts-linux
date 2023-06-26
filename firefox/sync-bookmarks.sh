#!/bin/bash

# Path to Firefox profile
PROFILE_PATH="/home/olof/.mozilla/firefox/Work"

# Export bookmarks from places.sqlite
echo 'SELECT b.guid as guid, b.title as title, b.dateAdded as dateAdded, b.lastModified as lastModified, p.url as url FROM moz_bookmarks as b JOIN moz_places as p ON b.fk = p.id WHERE b.type = 1;' | sqlite3 -json "$PROFILE_PATH/places.sqlite" > "bookmarks.json"
# Commit the changes
git add bookmarks.json
git commit -m "Update bookmarks"

# Push to GitHub
git push
