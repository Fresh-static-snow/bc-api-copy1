# frozen_string_literal: true

class Segment
  class Update < Match::Update

    private

    def update_resource
      if params[:logo] == ""
        resource&.logo&.purge
        resource.update(params.except(:logo))
      else
        resource.update(params)
      end
    end

  end
end
