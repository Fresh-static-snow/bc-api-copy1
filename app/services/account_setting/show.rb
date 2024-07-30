# frozen_string_literal: true

class AccountSetting
  class Show < BaseShowService

    def call
      AccountSettingSerializer.render_as_hash(resource)
    end

  end
end
