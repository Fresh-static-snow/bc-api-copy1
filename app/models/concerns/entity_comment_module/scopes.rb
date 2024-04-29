# frozen_string_literal: true

module EntityCommentModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_entity_type, -> (term) { where('entity_type = ?', term) }
      scope :filter_by_entity_id, -> (id) { where('entity_id = ?', id) }
    end

  end
end
