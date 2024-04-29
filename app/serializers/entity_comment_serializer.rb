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
class EntityCommentSerializer < Blueprinter::Base

  identifier :id

  view :list do
    field :message

    field :time do |corporate|
      corporate.created_at&.strftime('%H:%M %d.%m.%Y')
    end

    association :user, blueprint: UserSerializer, view: :user_name
    association :cover, blueprint: ImageSerializer
  end

end
