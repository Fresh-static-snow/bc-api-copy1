# frozen_string_literal: true

# == Schema Information
#
# Table name: user_notifications
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text
#  entity_action :string
#  entity_type   :string           not null
#  personal      :boolean
#  seen          :boolean          default(FALSE)
#  title         :string
#  created_at    :datetime
#  author_id     :integer
#  entity_id     :integer          not null
#  user_id       :integer
#
# Indexes
#
#  index_user_notifications_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class UserNotificationSerializer < Blueprinter::Base

  include ActionView::Helpers::DateHelper

  identifier :id

  fields :title, :description, :seen, :time_ago

  association :author, blueprint: UserSerializer, view: :calendar

  field :entity do |entity|
    entity_type = entity.entity_type
    entity_id = entity.entity_id

    resource = entity_type.constantize.with_deleted.where(id: entity_id).first

    data = {}
    if resource.present?
      entity_data = "#{entity_type}Serializer".constantize.render_as_hash(resource, view: :notify)
      data.merge!(entity_data) if entity_data.present?
    end

    data[:type] = entity_type
    data[:id] ||= entity_id
    data[:action] = entity.entity_action

    data
  end

end
