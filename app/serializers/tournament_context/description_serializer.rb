# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_descriptions
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text             not null
#  title         :string           not null
#  tournament_id :integer          not null
#
# Indexes
#
#  index_tournament_descriptions_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#
module TournamentContext
  class DescriptionSerializer < Blueprinter::Base

    identifier :id

    view :list do
      field :title
      field :description
    end

  end
end
