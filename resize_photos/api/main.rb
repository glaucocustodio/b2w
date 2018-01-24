require "sinatra"
require "json"
require_relative "../model/image"

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
end

get "/" do
  content_type :json

  images = Model::Image.new.all
  set_url_for(images).to_json
end
