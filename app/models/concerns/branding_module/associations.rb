# frozen_string_literal: true

module BrandingModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :logo, dependent: :purge_later
      has_one_attached :favicon, dependent: :purge_later
    end

  end
end
