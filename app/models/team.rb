# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  keyword            :string
#  name               :string
#  game_discipline_id :integer
#
# Indexes
#
#  index_teams_on_deleted_at  (deleted_at)
#
class Team < ApplicationRecord

  self.table_name = :teams

  acts_as_paranoid

  include Filterable
  include TeamModule::Associations
  include TeamModule::Scopes
  include TeamModule::Validations

end
