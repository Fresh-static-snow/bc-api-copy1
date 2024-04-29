# frozen_string_literal: true

# == Schema Information
#
# Table name: user_companies
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  title      :string           not null
#
# Indexes
#
#  index_user_companies_on_deleted_at  (deleted_at)
#
class UserCompanySerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :title

    association :cover, blueprint: ImageSerializer
  end

  view :edit do
    include_view :list

    association :users, blueprint: UserSerializer, view: :with_role
  end

  view :with_users_count do
    include_view :list

    field :user_count do |company|
      company.users.length
    end
  end

  view :notify do
    fields :id, :title
    field :is_deleted do |company|
      company.deleted_at.present?
    end
  end

end
