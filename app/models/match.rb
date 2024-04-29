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
module MatchContext

  def self.table_name_prefix
    'match_'
  end

end

class Match < ApplicationRecord

  self.table_name = :matches

  acts_as_paranoid

  include Filterable
  include MatchModule::Validations
  include MatchModule::Associations
  include MatchModule::Scopes

  BEST_OF = [
    { name: 'BO1', value: 1 }, { name: 'BO2', value: 2 }, { name: 'BO3', value: 3 }, { name: 'BO5', value: 5 }
  ].freeze

  def self.get_best_of_name(value)
    BEST_OF.find { |option| option[:value] == value }&.fetch(:name)
  end

  def self.get_best_of_value(name)
    BEST_OF.find { |option| option[:name] == name }&.fetch(:value)
  end

  def self.get_best_of(value)
    BEST_OF.find { |option| option[:value] == value }
  end

end
