# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  end_at             :date
#  start_at           :date
#  title              :string           not null
#  top                :integer          default(3), not null
#  ui_template        :jsonb
#  visible            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  game_discipline_id :integer
#  owner_id           :integer
#  region_id          :integer
#  type_id            :integer
#
# Indexes
#
#  index_tournaments_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (game_discipline_id => game_disciplines.id)
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (type_id => tournament_types.id)
#
class TournamentSerializer < Blueprinter::Base

  identifier :id

  common_fields = %i[
    title
    visible
    ui_template
  ].freeze

  field :tier do |tournament| # rubocop:disable Style/SymbolProc
    tournament.top
  end

  field :discipline_keyword do |tournament|
    tournament.discipline&.keyword
  end

  field :entity_type do
    :tournament
  end

  field :start_date do |tournament|
    tournament.start_at&.strftime('%Y-%m-%d')
  end

  field :end_date do |tournament|
    tournament.end_at&.strftime('%Y-%m-%d')
  end

  view :participants do
    association :main_participants, blueprint: UserSerializer, view: :calendar
    association :media_representatives, blueprint: UserSerializer, view: :calendar
  end

  view :staff do
    association :staff, blueprint: UserSerializer, view: :calendar
    association :analytics, blueprint: UserSerializer, view: :calendar
    association :commentators, blueprint: UserSerializer, view: :calendar
    association :backup_commentators, blueprint: UserSerializer, view: :calendar
    association :host_analytics, blueprint: UserSerializer, view: :calendar
  end

  view :show do
    fields(*common_fields)

    field :comments_count do |tournament|
      tournament.comments&.count
    end

    field :teams_count do |tournament|
      tournament.matches.distinct.pluck(:team_one_id, :team_two_id).count
    end

    include_view :staff
    include_view :participants

    association :sponsors, blueprint: SponsorSerializer, view: :list
    association :descriptions, blueprint: TournamentContext::DescriptionSerializer, view: :list

    association :region, blueprint: RegionSerializer, view: :list
    association :discipline, blueprint: GameDisciplineSerializer, view: :list
    association :owner, blueprint: UserSerializer, view: :list
    association :type, blueprint: TournamentContext::TypeSerializer, view: :list
    association :cover, blueprint: ImageSerializer
  end

  view :edit do
    include_view :show

    association :media, blueprint: TournamentContext::MediaSerializer, view: :list
  end

  view :day do
    fields(*common_fields)
    include_view :participants

    association :type, blueprint: TournamentContext::TypeSerializer, view: :list
  end

  view :week do
    include_view :day
  end

  view :month do
    include_view :day
  end

  view :quarter do
    fields(*common_fields)

    include_view :participants
    include_view :staff

    association :type, blueprint: TournamentContext::TypeSerializer, view: :list
  end

  view :year do
    fields(*common_fields)

    include_view :participants
    include_view :staff

    association :type, blueprint: TournamentContext::TypeSerializer, view: :list
  end

  view :list do
    fields :title, :ui_template

    association :discipline, blueprint: GameDisciplineSerializer, view: :list
  end

  view :notify do
    fields :id, :title
    field :is_deleted do |tournament|
      tournament.deleted_at.present?
    end
  end

end
