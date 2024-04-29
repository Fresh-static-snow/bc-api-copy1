# frozen_string_literal: true

class ImageSerializer < Blueprinter::Base

  field :url do |image|
    UrlGenerator.attachment_url(image)
  end

end
