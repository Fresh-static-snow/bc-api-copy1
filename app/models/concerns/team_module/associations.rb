# frozen_string_literal: true

module TeamModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :game_discipline
      alias_method :discipline, :game_discipline
    end

  end
end
