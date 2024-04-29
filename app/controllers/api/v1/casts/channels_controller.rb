# frozen_string_literal: true

module Api
  module V1
    module Casts
      class ChannelsController < BaseCrudController

        private

        def resource_class
          CastContext::Channel
        end

        def search_params
          params.permit(%i[term scope with_history])
        end

        def resource_params
          params.permit(
            :id,
            :name
          )
        end

      end
    end
  end
end
