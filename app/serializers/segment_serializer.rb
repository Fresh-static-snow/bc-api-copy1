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
class SegmentSerializer < Blueprinter::Base

  identifier :id

  view :match_segment do
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

  view :show do
    fields :visible, :type

    field :format do |show|
      Segment.get_best_of(show.best_of)
    end

    field :comments_count do |segment|
      segment.comments.size
    end

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

    include_view :staff
    include_view :show_segment
    association :tournament, blueprint: TournamentSerializer, view: :list
    association :game_discipline, blueprint: GameDisciplineSerializer, view: :list
  end

  view :edit do
    include_view :calendar

    field :start_date do |match|
      match.start_at&.strftime('%Y-%m-%d')
    end

    field :format do |show|
      Segment.get_best_of(show.best_of)
    end

    include_view :segment_context
    include_view :staff
    association :tournament, blueprint: TournamentSerializer, view: :list
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
    field :title

    association :cover, blueprint: ImageSerializer
    association :logo, blueprint: ImageSerializer
    association :guests, blueprint: SegmentContext::GuestSerializer
    association :descriptions, blueprint: SegmentContext::DescriptionSerializer
    association :media, blueprint: SegmentContext::MediaSerializer
  end

  view :staff do
    association :commentators, blueprint: UserSerializer, view: :calendar
    association :analytics, blueprint: UserSerializer, view: :calendar
    association :staff_members, blueprint: UserSerializer, view: :calendar
    association :backup_commentators, blueprint: UserSerializer, view: :calendar
    association :host_analytics, blueprint: UserSerializer, view: :calendar
  end

  view :show_segment do
    association :analytic_studios, blueprint: CastContext::AnalyticStudioSerializer, view: :list
    association :studios, blueprint: CastContext::StudioSerializer, view: :list
    association :setups, blueprint: CastContext::SetupSerializer, view: :list
    association :streams, blueprint: CastContext::StreamSerializer, view: :list
    association :languages, blueprint: CastContext::LanguageSerializer, view: :list
    association :channels, blueprint: CastContext::ChannelSerializer, view: :list
  end

end
