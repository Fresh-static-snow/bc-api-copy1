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
module TournamentContext

  def self.table_name_prefix
    'tournament_'
  end

end

class Tournament < ApplicationRecord

  self.table_name = :tournaments

  acts_as_paranoid

  before_validation :set_default_fields_if_empty

  include Filterable
  include Attachable
  include TournamentModule::Colorable
  include TournamentModule::Validations
  include TournamentModule::Associations
  include TournamentModule::Scopes

  private

  def reject_descriptions(attributes)
    attributes['title'].blank? || attributes['description'].blank?
  end

  def reject_media(attributes)
    attributes['title'].blank? || attributes['description'].blank?
  end

  def set_default_fields_if_empty
    self.end_at ||= start_at
    self.top ||= 3
    self.ui_template = (ui_template.presence || AVAILABLE_COLORS.values.sample)
  end

end
