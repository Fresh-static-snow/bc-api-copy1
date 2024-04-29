# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_comments
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  entity_type :string
#  message     :text
#  created_at  :datetime
#  entity_id   :integer
#  user_id     :integer
#
# Indexes
#
#  index_entity_comments_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class EntityComment < ApplicationRecord

  self.table_name = :entity_comments

  acts_as_paranoid

  include Attachable
  include Filterable
  include EntityCommentModule::Associations
  include EntityCommentModule::Scopes
  include EntityCommentModule::Validations

end
