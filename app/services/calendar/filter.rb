# frozen_string_literal: true

class Calendar
  class Filter

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call # rubocop:disable Metrics/AbcSize
      Rails.cache.fetch('calendar:filters', expires_in: 1.minute) do
        {
          'game_discipline' => GameDiscipline::List.call(params),
          'studio' => CastContext::Studio::List.call(params),
          'analytic_studio' => CastContext::AnalyticStudio::List.call(params),
          'setup' => CastContext::Setup::List.call(params),
          'stream' => CastContext::Stream::List.call(params),
          'channel' => CastContext::Channel::List.call(params),
          'managers' => User::List.call(params.merge(scope: :managers)),
          'main_participants' => User::List.call(params.merge(scope: :main_participants)),
          'media_representatives' => User::List.call(params.merge(scope: :media_representatives)),
          'staff_members' => User::List.call(params.merge(scope: :staff_members)),
          'analytics' => User::List.call(params.merge(scope: :analytics)),
          'commentators' => User::List.call(params.merge(scope: :commentators))
        }
      end
    end

    attr_reader :params

  end
end
