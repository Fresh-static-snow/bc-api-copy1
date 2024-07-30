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
class Segment < Match

  include Attachable
  include SegmentModule::Associations
  include SegmentModule::Validations

  BEST_OF = [
    { name: 'Talk', value: 1 }
  ].freeze

  def self.get_best_of(value)
    BEST_OF.find { |option| option[:value] == value }
  end

end
