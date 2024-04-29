# frozen_string_literal: true

module Api
  module V1
    class ManagementItemsController < BaseCrudController

      def items
        data = ManagementContext::Items::List.call({})

        render_json_response(true, data, :ok)
      end

    end
  end
end
