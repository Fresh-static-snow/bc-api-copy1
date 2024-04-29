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
class UserDiscipline < ApplicationRecord

  self.table_name = :user_disciplines

  acts_as_paranoid

  include Filterable
  include UserDisciplineModule::Validations
  include UserDisciplineModule::Associations
  include UserDisciplineModule::Scopes

end
