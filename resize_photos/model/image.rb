require_relative "../processor/image"
require_relative "base"

module Model
  class Image < Base
    def self.save_from_url(url)
      model = new

      unless model.exists?(original_url: url)
        processor = Processor::Image.new(url)

        model.insert({
          original_url: url,
          large: processor.resize("640x480"),
          medium: processor.resize("384x288"),
          small: processor.resize("320x240")
        })
      end
    end

    def all(except: ["_id"])
      super().map do |current|
        current.to_h.delete_if { |key| except.include?(key) }
      end
    end

    private

    def collection_name
      :images
    end
  end
end

