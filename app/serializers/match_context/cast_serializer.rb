# frozen_string_literal: true

# == Schema Information
#
# Table name: match_casts
#
#  id                      :bigint           not null, primary key
#  deleted_at              :datetime
#  cast_analytic_studio_id :integer
#  cast_channel_id         :integer
#  cast_language_id        :integer
#  cast_studio_id          :integer
#  match_id                :integer
#
# Indexes
#
#  index_match_casts_on_deleted_at  (deleted_at)
#  index_match_casts_on_match_id    (match_id)
#
module MatchContext
  class CastSerializer < Blueprinter::Base

    identifier :id

    view :staff do
      association :commentators, blueprint: UserSerializer, view: :calendar
      association :analytics, blueprint: UserSerializer, view: :calendar
      association :staff_members, blueprint: UserSerializer, view: :calendar
      association :backup_commentator, blueprint: UserSerializer, view: :calendar
      association :host_analytic, blueprint: UserSerializer, view: :calendar
    end

    view :calendar do
      include_view :edit
    end

    view :edit do
      association :analytic_studio, blueprint: CastContext::AnalyticStudioSerializer, view: :list
      association :studio, blueprint: CastContext::StudioSerializer, view: :list
      association :language, blueprint: CastContext::LanguageSerializer, view: :list
      association :channels, blueprint: CastContext::ChannelSerializer, view: :list

      include_view :staff
    end

    view :tournament do
      include_view :staff
    end

  end
end
