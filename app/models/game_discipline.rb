# frozen_string_literal: true

# == Schema Information
#
# Table name: game_disciplines
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string
#  order      :integer          default(0)
#  title      :string           not null
#
# Indexes
#
#  index_game_disciplines_on_deleted_at  (deleted_at)
#
class GameDiscipline < ApplicationRecord

  self.table_name = :game_disciplines

  acts_as_paranoid

  include Filterable
  include GameDisciplineModule::Validations
  include GameDisciplineModule::Associations
  include GameDisciplineModule::Scopes

end
