# frozen_string_literal: true

module CorporateCompanyModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :cover, dependent: :purge_later

      has_many :corporates, foreign_key: :company_id, dependent: :destroy, inverse_of: :company
    end

  end
end
