# frozen_string_literal: true

class Setting
  class Show < BaseShowService

    def call
      SettingSerializer.render_as_hash(resource)
    end

  end
end
