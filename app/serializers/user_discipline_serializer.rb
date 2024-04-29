# frozen_string_literal: true

# == Schema Information
#
# Table name: user_disciplines
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  title      :string
#
# Indexes
#
#  index_user_disciplines_on_deleted_at  (deleted_at)
#
class UserDisciplineSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :title
  end

end
