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
class GameDisciplineSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :title, :keyword

    association :cover, blueprint: ImageSerializer
  end

  view :notify do
    fields :id, :title
    field :is_deleted do |game_discipline|
      game_discipline.deleted_at.present?
    end
  end

end
