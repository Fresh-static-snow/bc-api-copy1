# frozen_string_literal: true

module UserCompanyModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :cover, dependent: :purge_later

      has_many :users, class_name: 'User', foreign_key: :company_id, dependent: :nullify, inverse_of: :company
      accepts_nested_attributes_for :users
    end

  end
end
