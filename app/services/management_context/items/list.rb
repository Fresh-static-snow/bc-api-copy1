# frozen_string_literal: true

module ManagementContext
  module Items
    class List < BaseListService

      AVAILABLE_ITEMS = { 'Discipline': GameDiscipline, 'Tournament': Tournament, 'Match': Match,
                          'Studio': CastContext::Studio, 'Studio analytics': CastContext::AnalyticStudio,
                          'Channel': CastContext::Channel, 'Language': CastContext::Language, 'Team': Team,
                          'Sponsor': Sponsor, 'Seasonal branding': Branding }.freeze

      def call
        {
          **items_object,
          'Deleted items': {
            count: deleted_items_object.sum(&:second),
            items: deleted_items_object
          }
        }
      end

      private

      def items_object
        AVAILABLE_ITEMS.transform_values { |value| value.all.count }
      end

      def deleted_items_object
        @deleted_items_object ||= AVAILABLE_ITEMS.transform_values { |value| value.only_deleted.count }
      end

    end
  end
end
