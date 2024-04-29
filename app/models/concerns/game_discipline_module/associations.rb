# frozen_string_literal: true

module GameDisciplineModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :cover, dependent: :purge_later

      has_many :tournaments, dependent: :destroy
      has_many :teams, dependent: :destroy
    end

  end
end
