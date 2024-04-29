# frozen_string_literal: true

class Match
  class List < BaseListService

    attr_reader :current_user

    def self.call(params, current_user)
      new(params, current_user).call
    end

    def initialize(params, current_user)
      @current_user = current_user

      super(params)
    end

    def call
      if only_deleted?
        deleted_resource
      else
        MatchSerializer.render_as_hash(resource, view: :calendar,
                                                 current_user: current_user)
      end
    end

  end
end
