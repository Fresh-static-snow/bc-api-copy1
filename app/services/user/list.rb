# frozen_string_literal: true

class User
  class List < Base

    UNFILTERABLE_PARAMS = %i[start_at end_at match_id].freeze

    def self.call(params)
      new(params).call
    end

    def call
      users = UserSerializer.render_as_hash(resources, view: view_mode, **additional_options)
      scope == :participants ? users_by_discipline(users) : users
    end

    private

    attr_reader :params, :scope

    def initialize(params)
      @scope = params.delete(:scope)&.to_sym
      @params = params
    end

    def resources
      users = User::SCOPES_BY_DISCIPLINE_OR_DEFAULT.include?(scope.to_s) ? User.public_send(scope) : User.all

      @resources ||= User.filter(params.except(*UNFILTERABLE_PARAMS), users)
                         .includes(avatar_attachment: :blob)
                         .sort_by_display_name
    end

    def view_mode
      scope || :common
    end

    def users_by_discipline(users)
      grouped = Hash.new { |hash, key| hash[key] = [] }

      users.each do |user|
        user[:user_disciplines].each do |discipline|
          grouped[discipline[:title]] << user
        end
      end

      grouped.keys.map do |discipline|
        {
          discipline: discipline,
          users: grouped[discipline]
        }
      end
    end

    def additional_options
      return params.slice(:start_at, :end_at, :match_id) if params[:end_at] && params[:start_at]
      return params.slice(:start_at, :match_id) if params[:start_at]

      {}
    end

  end
end
