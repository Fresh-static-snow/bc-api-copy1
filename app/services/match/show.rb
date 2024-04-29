# frozen_string_literal: true

class Match
  class Show < BaseShowService

    attr_reader :current_user

    def self.call(resource, current_user)
      new(resource, current_user).call
    end

    def initialize(resource, current_user)
      @current_user = current_user

      super(resource)
    end

    def call
      MatchSerializer.render_as_hash(resource, view: :calendar, current_user: current_user)
    end

  end
end
