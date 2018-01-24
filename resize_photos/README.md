# Resize Photos – Challenge

Given a Webservice endpoint (http://54.152.221.29/images.json), that returns a JSON of
ten photos, consume it and generate three different photo formats for each one, that must
be small (320x240), medium (384x288) and large (640x480).

Finally, write a Webservice endpoint, which should use a non-relational
database (MongoDB preferred) and list (in JSON format) all ten photos with their
respective formats, providing their URLs.

# Solution

It was created in Ruby because this is the language I am more familiar with.

The image files are downloaded, resized and saved into `public` dir.

The data are saved into `images` collection.

# Requirements

- ImageMagick or GraphicsMagick command-line tool (check running `convert -version`)
- MongoDB (running at `127.0.0.1:27017`)
- Redis (running at `127.0.0.1:6379` for cache)

# Commands

Install gems: `bundle install`

Run tests: `bundle exec rspec`

Consume remote API and resize images: `ruby consumer/resolver.rb`

Expose JSON API: `ruby api/main.rb` (address `http://localhost:4567/`)
