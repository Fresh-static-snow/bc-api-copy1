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
  class TypeSerializer < Blueprinter::Base

    identifier :id

    view :list do
      field :name
    end

  end
end
