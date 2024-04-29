# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_media
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text             not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tournament_id :integer          not null
#
# Indexes
#
#  index_tournament_media_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#
module TournamentContext
  class MediaSerializer < Blueprinter::Base

    identifier :id

    view :list do
      field :title
      field :description

      field :updated_at do |tournament|
        tournament.updated_at&.strftime('%H:%M %d.%m.%Y')
      end
    end

  end
end
