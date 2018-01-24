require "mini_magick"

module Processor
  class Image
    attr_reader :url, :file_name

    def initialize(url)
      @url = url
    end

    def resize(size)
      image.resize(size)
      save("#{size}_#{file_name}")
    end

    private

    def save(file_name)
      file_name.tap { |file_name| image.write("#{public_path}/#{file_name}") }
    end

    def public_path
      "#{Dir.pwd}/public"
    end

    def file_name
      @file_name ||= url.split("/").last
    end

    def image
      @image ||= MiniMagick::Image.open(url)
    end
  end
end
