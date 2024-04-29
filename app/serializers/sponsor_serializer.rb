# frozen_string_literal: true

# == Schema Information
#
# Table name: sponsors
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#
# Indexes
#
#  index_sponsors_on_deleted_at  (deleted_at)
#
class SponsorSerializer < Blueprinter::Base

  identifier :id

  view :list do
    field :name
  end

  view :with_history do
    include_view :list

    field :events_count do |record|
      record.tournaments.size
    end

    field :related_events do |record|
      record.tournaments.map do |tournament|
        {
          id: tournament.id,
          title: tournament.title
        }
      end
    end
  end

end
