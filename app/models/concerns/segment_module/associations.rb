# frozen_string_literal: true

module SegmentModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :logo, dependent: :purge

      has_many :comments, -> { unscope(where: :entity_type).where(entity_type: 'Segment') },
               class_name: 'EntityComment', as: :entity, dependent: :destroy, inverse_of: :entity

      has_many :guests, class_name: 'SegmentContext::Guest', dependent: :destroy
      accepts_nested_attributes_for :guests, allow_destroy: true

      has_many :descriptions, class_name: 'SegmentContext::Description', dependent: :destroy
      accepts_nested_attributes_for :descriptions, allow_destroy: true

      has_many :media, class_name: 'SegmentContext::Media', dependent: :destroy
      accepts_nested_attributes_for :media, allow_destroy: true

      has_many :commentators, -> { User.with_deleted.with_history.order('match_commentators.id') },
               through: :match_casts, source: :commentators

      has_many :staff_members, -> { User.with_deleted.with_history.order('match_staff_members.id') },
               through: :match_casts, source: :staff_members

      has_many :analytics, -> { User.with_deleted.with_history.order('match_analytics.id') },
               through: :match_casts, source: :analytics

      has_many :backup_commentators, through: :match_casts, source: :backup_commentators

      has_one :game_discipline, through: :tournament, source: :game_discipline

      has_many :host_analytics, through: :match_casts, source: :host_analytic
      has_many :studios, through: :match_casts, source: :studio
      has_many :setups, through: :match_casts, source: :setup
      has_many :languages, through: :match_casts, source: :language
      has_many :channels, through: :match_casts, source: :channels
      has_many :analytic_studios, through: :match_casts, source: :analytic_studio
      has_many :streams, through: :match_casts, source: :stream
    end

  end
end
