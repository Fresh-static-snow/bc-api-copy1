# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_languages
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string
#  name       :string
#
# Indexes
#
#  index_cast_languages_on_deleted_at  (deleted_at)
#
module CastContext
  class LanguageSerializer < ApplicationSerializer

    view :list do
      fields :name, :keyword
    end

  end
end
