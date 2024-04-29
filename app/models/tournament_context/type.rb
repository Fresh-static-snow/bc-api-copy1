# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_types
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string           not null
#
# Indexes
#
#  index_tournament_types_on_deleted_at  (deleted_at)
#
module TournamentContext
  class Type < ApplicationRecord

    self.table_name = :tournament_types

    acts_as_paranoid

    include Filterable
    include TypeModule::Associations
    include TypeModule::Scopes

  end
end
