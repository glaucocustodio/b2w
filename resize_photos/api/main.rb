require "sinatra"
require "json"
require "redis"
require "object/cache"
require_relative "../model/image"

Cache.backend = Redis.new

set :public_dir, "public"

helpers do
  def set_url_for(records)
    records.map do |current|
      current["small_url"] = "#{request.base_url}/#{current["small"]}"
      current["medium_url"] = "#{request.base_url}/#{current["medium"]}"
      current["large_url"] = "#{request.base_url}/#{current["large"]}"
      current
    end
  end

  def cache(prefix, expires_after: 3_600)
    return yield if ENV["RACK_ENV"] == "test"
    Cache.new(key_prefix: prefix, ttl: expires_after) { yield }
  end
end

get "/" do
  content_type :json

  cache("images") do
    images = Model::Image.new.all
    set_url_for(images).to_json
  end
end
