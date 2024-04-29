# frozen_string_literal: true

module LanguageModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_casts, foreign_key: :cast_language_id, dependent: :destroy, inverse_of: :language
    end

  end
end
