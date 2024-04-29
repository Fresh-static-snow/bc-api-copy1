# frozen_string_literal: true

class BaseSoftDestroyService < BaseDeleteService

  def call
    with_transaction do
      resource.destroy
    end

    collect_errors(resource)

    resource
  end

end
