# frozen_string_literal: true

class BaseRestoreService < BaseDeleteService

  def call
    with_transaction do
      resource.recover
    end

    collect_errors(resource)

    resource
  end

end
