# frozen_string_literal: true

module Api
  module V1
    module Casts
      class LanguagesController < BaseCrudController

        private

        def resource_class
          CastContext::Language
        end

        def search_params
          params.permit(%i[term scope with_history])
        end

        def resource_params
          params.permit(
            :id,
            :name,
            :keyword
          )
        end

      end
    end
  end
end
