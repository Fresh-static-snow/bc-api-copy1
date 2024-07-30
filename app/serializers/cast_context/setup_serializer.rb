# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_setups
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cast_setups_on_deleted_at  (deleted_at)
#
module CastContext
  class SetupSerializer < ApplicationSerializer

    view :list do
      fields :name
    end

  end
end
