# frozen_string_literal: true

module CalendarCorporates

  extend ActiveSupport::Concern

  included do
    private

    def corporates # rubocop:disable Metrics/AbcSize
      join_includes = [
        { corporate_main_participants: { user: { avatar_attachment: :blob } } },
        { corporate_participants: { user: { avatar_attachment: :blob } } },
        { cover_attachment: :blob },
        { company: { cover_attachment: :blob } }
      ]

      results = Corporate.includes(*join_includes)
      results = results.only_visible unless current_user.permission?(Corporate.name, :visible)
      results = results.distinct.select(
        'corporates.description, corporates.visible, corporates.location, corporates.name, corporates.ui_template,
          corporates.start_at, corporates.end_at, corporates.company_id, corporates.id'
      ).left_joins(*join_includes)

      corporate_filters = if calendar_params[:current_user]&.include?('true')
                            filter_params_for_current_user
                          else
                            filter_params_for_filter
                          end

      raw_corporates = Corporate.filter(
        corporate_filters.except(:game_discipline),
        results.distinct.sort_by_date
      )

      case view_mode
      when :day
        group_and_serialize_corporates_by_company(raw_corporates)
      when :quarter, :year
        group_and_serialize_corporates_by_company_tier(raw_corporates)
      else
        group_and_serialize_corporates_by_date_and_company(raw_corporates)
      end
    end

    def group_and_serialize_corporates_by_company(raw_corporates)
      raw_corporates.group_by(&:company).map { |company, corporates| discipline_with_corporates(company, corporates) }
    end

    def group_and_serialize_corporates_by_company_tier(raw_corporates)
      raw_corporates.group_by(&:company).map do |company, corporates|
        {
          discipline: CorporateCompanySerializer.render_as_hash(company, view: :list),
          corporates: [{
            tier: 3,
            list: CorporateSerializer.render_as_hash(corporates, view: :calendar)
          }]
        }
      end
    end

    def group_and_serialize_corporates_by_date_and_company(raw_corporates) # rubocop:disable Metrics/AbcSize
      filtered_corporates = raw_corporates.group_by { |corporate| [corporate.start_at.to_date, corporate.company] }

      group = filtered_corporates.each_with_object({}) do |((date, company), corporates), m|
        m[date] ||= {}
        m[date][company] = corporates
      end

      group.map do |date, companies|
        {
          date: date,
          type: :corporate,
          disciplines: companies.map { |company, corporates| discipline_with_corporates(company, corporates) }
        }
      end
    end

    def discipline_with_corporates(company, corporates)
      {
        discipline: CorporateCompanySerializer.render_as_hash(company, view: :list),
        corporates: CorporateSerializer.render_as_hash(corporates, view: :calendar)
      }
    end
  end

end
