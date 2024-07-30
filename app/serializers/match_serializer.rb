# frozen_string_literal: true

# == Schema Information
#
# Table name: matches
#
#  id               :bigint           not null, primary key
#  best_of          :integer
#  deleted_at       :datetime
#  end_at           :datetime
#  google_event_ids :jsonb
#  start_at         :datetime
#  title            :string
#  type             :string
#  visible          :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  team_one_id      :integer
#  team_two_id      :integer
#  tournament_id    :integer
#
# Indexes
#
#  index_matches_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (team_one_id => teams.id)
#  fk_rails_...  (team_two_id => teams.id)
#  fk_rails_...  (tournament_id => tournaments.id)
#
class MatchSerializer < Blueprinter::Base

  identifier :id

  view :match_segment do
    field :team_one, if: -> (_field_name, match, _options) { !match.type_segment? } do |match|
      match.team_one ? match.team_one&.name : 'TBD'
    end

    field :team_two, if: -> (_field_name, match, _options) { !match.type_segment? } do |match|
      match.team_two ? match.team_two&.name : 'TBD'
    end

    field :format, if: -> (_field_name, match, _options) { !match.type_segment? } do |match|
      Match.get_best_of_name(match.best_of)
    end

    include_view :segment_context
  end

  view :calendar do
    fields :visible, :type

    include_view :match_segment

    field :start_time do |match|
      match.start_at&.strftime('%H:%M')
    end

    field :end_time do |match|
      match.end_at&.strftime('%H:%M')
    end

    field :start_date do |match|
      match.start_at&.strftime('%Y-%m-%d')
    end

    association :match_casts, blueprint: MatchContext::CastSerializer, view: :calendar,
                              if: -> (_field_name, match, options) {
                                    match.visible && match.tournament.visible ||
                                      User.with_permission(:create_entity).exists?(options[:current_user].id)
                                  }
  end

  view :edit do
    include_view :calendar

    field :start_date do |match|
      match.start_at&.strftime('%Y-%m-%d')
    end

    association :team_one, blueprint: TeamSerializer, view: :list, if: -> (_field_name, match, _options) {
      !match.type_segment?
    }
    association :team_two, blueprint: TeamSerializer, view: :list, if: -> (_field_name, match, _options) {
      !match.type_segment?
    }

    field :format do |show|
      show.type_segment? ? Segment.get_best_of(show.best_of) : Match.get_best_of(show.best_of)
    end

    include_view :segment_context
    association :tournament, blueprint: TournamentSerializer, view: :list
    association :match_casts, blueprint: MatchContext::CastSerializer, view: :edit
  end

  view :schedule do
    include_view :calendar

    field :start_date do |match|
      match.start_at&.strftime('%Y-%m-%d')
    end
  end

  view :notify do
    field :id do |match|
      match.tournament&.id
    end
    field :title do |match|
      "#{match.tournament&.title}: #{match.team_one&.name} vs #{match.team_two&.name}"
    end
    field :is_deleted do |match|
      match.deleted_at.present?
    end
  end

  view :segment_context do
    field :title, if: -> (_field_name, match, _options) { match.type_segment? }

    association :cover, blueprint: ImageSerializer, if: -> (_field_name, match, _options) { match.type_segment? }

    association :logo, blueprint: ImageSerializer, if: -> (_field_name, match, _options) { match.type_segment? }

    association :guests, blueprint: SegmentContext::GuestSerializer, if: -> (_field_name, match, _options) {
                                                                           match.type_segment?
                                                                         }
    association :descriptions, blueprint: SegmentContext::DescriptionSerializer, if: -> (_field_name, match, _options) {
                                                                                       match.type_segment?
                                                                                     }
    association :media, blueprint: SegmentContext::MediaSerializer, if: -> (_field_name, match, _options) {
                                                                          match.type_segment?
                                                                        }
  end

end
