# frozen_string_literal: true

# == Schema Information
#
# Table name: corporates
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text
#  end_at      :datetime
#  location    :string
#  name        :string           not null
#  start_at    :datetime
#  ui_template :jsonb
#  visible     :boolean          default(FALSE), not null
#  company_id  :integer
#
# Indexes
#
#  index_corporates_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => corporate_companies.id)
#
class CorporateSerializer < Blueprinter::Base

  identifier :id

  view :calendar do
    fields :description, :visible, :location, :name, :ui_template

    field :entity_type do
      :corporate
    end

    field :discipline_keyword do |corporate|
      corporate.company&.keyword
    end

    field :start_date do |corporate|
      corporate.start_at&.strftime('%Y-%m-%d')
    end

    field :start_time do |corporate|
      corporate.start_at&.strftime('%H:%M')
    end

    field :end_time do |corporate|
      corporate.end_at&.strftime('%H:%M')
    end

    association :company, blueprint: CorporateCompanySerializer, view: :list
    association :main_participants, blueprint: UserSerializer, view: :calendar
    association :cover, blueprint: ImageSerializer
  end

  view :show do
    include_view :calendar
    association :participants, blueprint: UserSerializer, view: :participants

    field :comments_count do |corporate|
      corporate.comments&.count
    end
  end

  view :notify do
    field :id
    field :title do |corporate| # rubocop:disable Style/SymbolProc
      corporate.name
    end
    field :is_deleted do |corporate|
      corporate.deleted_at.present?
    end
  end

end
