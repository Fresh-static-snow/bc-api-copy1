# frozen_string_literal: true

class UrlGenerator

  def self.attachment_url(file)
    return '' unless file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(file)
  end

end
