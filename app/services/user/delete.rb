# frozen_string_literal: true

class User

  class Delete < BaseDeleteService; end

  private

  def delete_resource
    resource.destroy
  end

end
