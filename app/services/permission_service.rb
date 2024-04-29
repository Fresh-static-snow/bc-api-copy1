# frozen_string_literal: true

class PermissionService

  ALL = %w[index show edit update create destroy soft_destroy restore].freeze

  EXCLUDED_CLASS_NAMES = %w[Class ActiveStorage::Attachment ActiveStorage::Blob].freeze

  BASIC_MODELS = [
    Corporate.name, GameDiscipline.name, Tournament.name, Match.name, MatchCast.name, Sponsor.name,
    User.name, UserCompany.name, CorporateCompany.name, UserDiscipline.name, Role.name, Branding.name
  ].freeze

  ADMIN_PERMISSIONS = %w[DashboardController].freeze

  def self.filtered_class_names
    return @filtered_class_names if @filtered_class_names.present?

    model_classes = [Corporate, GameDiscipline, Tournament, Match, MatchCast,
                     UserCompany, CorporateCompany, UserDiscipline, Branding]

    class_names = model_classes.flat_map { |model_class| model_class.reflect_on_all_associations.map(&:class_name) }

    @filtered_class_names = (BASIC_MODELS + class_names) - EXCLUDED_CLASS_NAMES
  end

  def self.generate_routes(model_name, action, is_pluralized: true)
    routes = []
    if action == :all
      %i[index show create edit update destroy soft_destroy restore].each do |a|
        route = generate_route(model_name, a, is_pluralized)

        routes << route
      end
    else
      route = generate_route(model_name, action, is_pluralized)

      routes << route
    end

    routes
  end

  def self.generate_route(model_name, action, is_pluralized)
    api_path = '/api/v1/'
    path = is_pluralized ? model_name.downcase.pluralize : model_name.downcase
    base_path = "#{api_path}#{path}"

    case action
    when :index
      "get::#{base_path}"
    when :show
      "get::#{base_path}/:id"
    when :create
      "post::#{base_path}"
    when :edit
      "get::#{base_path}/:id/edit"
    when :update
      "put::#{base_path}/:id"
    when :destroy
      "delete::#{base_path}/:id"
    when :restore
      "put::#{base_path}/:id/restore"
    when :soft_destroy
      "delete::#{base_path}/:id/soft_destroy"
    when :bulk_destroy
      "delete::#{base_path}/destroy"
    when :bulk_restore
      "put::#{base_path}/restore"
    when :bulk_soft_destroy
      "delete::#{base_path}/soft_destroy"
    end
  end

  def self.permissions # rubocop:disable Metrics/AbcSize
    return @permissions if @permissions.present?

    resource_actions = %i[index show create edit update destroy all restore soft_destroy]

    permissions = []
    filtered_class_names.uniq.each do |name|
      resource_actions += %i[bulk_destroy bulk_restore bulk_soft_destroy] if name == 'Match'

      resource_actions.each do |action|
        %i[grant deny].each do |access_type|
          routes = []
          routes = generate_routes(name, action) if access_type == :grant
          permissions << {
            id: permissions.length,
            name: "#{name}: #{access_type} #{action}",
            target_type: :model,
            target_name: name,
            access_type: access_type,
            access_for: action,
            allowed_routes: routes
          }
        end
      end
    end

    %i[day week month quarter year].each do |action|
      %i[grant deny].each do |access_type|
        permissions << {
          id: permissions.length,
          name: "Calendar #{action}: show",
          target_type: :model,
          target_name: Calendar.name,
          access_type: access_type,
          access_for: action,
          allowed_routes: "get::/api/v1/calendar?scope=#{action}"
        }
      end
    end

    %i[counts users companies notifications].each do |action|
      %i[grant deny].each do |access_type|
        permissions << {
          id: permissions.length,
          name: "Dashboard #{action}: show",
          target_type: :controller,
          target_name: Api::V1::DashboardController.name,
          access_type: access_type,
          access_for: action,
          allowed_routes: "get::/api/v1/dashboard/#{action}"
        }
      end
    end

    [Corporate.name, Tournament.name, Match.name].freeze.each do |name|
      %i[grant deny].each do |access_type|
        permissions << {
          id: permissions.length,
          name: "#{name}: #{access_type} unpublished",
          target_type: :model,
          target_name: name,
          access_type: access_type,
          access_for: :only_visible,
          allowed_routes: nil
        }
      end
    end

    permissions = permissions.uniq

    permissions << {
      id: :calendar_day,
      name: "Calendar View: Day",
      description: "Toggle display interval: Day",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :calendar_week,
      name: "Calendar View: Week",
      description: "Toggle display interval: Week",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :calendar_month,
      name: "Calendar View: Month",
      description: "Toggle display interval: Month",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :calendar_quarter,
      name: "Calendar View: Quarter",
      description: "Toggle display interval: Quarter",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :calendar_year,
      name: "Calendar View: Year",
      description: "Toggle display interval: Year",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :event_view,
      name: "Unpublished entities",
      description: "View unpublished events",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :create_entity,
      name: "Create/Edit entities",
      description: "Create/Edit entities (discipline, event, match, corporate)",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :event_comment,
      name: "Entity comments",
      description: "Add comments to the event",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :dashboard_view,
      name: "Access to the user management section",
      description: "Access to the user management section (globally go to the page)",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }
    permissions << {
      id: :dashboard_all,
      name: "Ability to create and edit entities in the user management section",
      description: "Ability to create and edit entities in the user management section (people, companies, roles)",
      target_type: :special,
      target_name: nil,
      access_type: nil,
      access_for: nil
    }

    @permissions = permissions
  end

  def self.map_special_permission # rubocop:disable Metrics/AbcSize
    @map_special_permission ||= {
      calendar_day: permissions.filter do |p|
        %w[Calendar Tournament Match Corporate].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[day index show].include?(p[:access_for])
      end.pluck(:id),
      calendar_week: permissions.filter do |p|
        %w[Calendar Tournament Match Corporate].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[week index show].include?(p[:access_for])
      end.pluck(:id),
      calendar_month: permissions.filter do |p|
        %w[Calendar Tournament Match Corporate].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[month index show].include?(p[:access_for])
      end.pluck(:id),
      calendar_quarter: permissions.filter do |p|
        %w[Calendar Tournament Match Corporate].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[quarter index show].include?(p[:access_for])
      end.pluck(:id),
      calendar_year: permissions.filter do |p|
        %w[Calendar Tournament Match Corporate].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[year index show].include?(p[:access_for])
      end.pluck(:id),
      event_view: permissions.filter do |p|
        %w[Tournament Match Corporate GameDiscipline].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[only_visible].include?(p[:access_for])
      end.pluck(:id),
      create_entity: permissions.filter do |p|
        %w[Tournament Match Corporate GameDiscipline].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[all].include?(p[:access_for])
      end.pluck(:id) + permissions.filter do |p|
        %w[
          User
          Region
          MatchCast
          CastContext::Channel
          CastContext::Language
          CastContext::AnalyticStudio
          CastContext::Studio
          MatchContext::Analytics
          MatchContext::Commentators
          MatchContext::StaffMembers
          TournamentContext::Type
          TournamentContext::Description
          TournamentContext::Media
          TournamentContext::MainParticipants
          TournamentContext::MediaRepresentatives
          CorporateCompany
          CorporateMainParticipants
          CorporateParticipants
        ].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[index show].include?(p[:access_for])
      end.pluck(:id) + permissions.filter do |p|
        %w[Team Sponsor TournamentContext::Sponsors].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[index show create edit update restore soft_destroy destroy].include?(p[:access_for])
      end.pluck(:id),
      event_comment: permissions.filter do |p|
        %w[EntityComment].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[all].include?(p[:access_for])
      end.pluck(:id),
      dashboard_view: permissions.filter do |p|
        %w[Api::V1::DashboardController User Role UserCompany].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[counts users companies notifications index show edit].include?(p[:access_for])
      end.pluck(:id),
      dashboard_all: permissions.filter do |p|
        %w[User Role UserCompany].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[all].include?(p[:access_for])
      end.pluck(:id) + permissions.filter do |p|
        %w[
          User
          Region
          MatchCast
          CastContext::Channel
          CastContext::Language
          CastContext::AnalyticStudio
          CastContext::Studio
          MatchContext::Analytics
          MatchContext::Commentators
          MatchContext::StaffMembers
          TournamentContext::Type
          TournamentContext::Description
          TournamentContext::Media
          TournamentContext::MainParticipants
          TournamentContext::MediaRepresentatives
          CorporateCompany
          CorporateMainParticipants
          CorporateParticipants
          Branding
        ].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[all].include?(p[:access_for])
      end.pluck(:id) + permissions.filter do |p|
        %w[
          Match
        ].include?(p[:target_name]) &&
          %i[grant].include?(p[:access_type]) &&
          %i[bulk_destroy bulk_restore bulk_soft_destroy].include?(p[:access_for])
      end.pluck(:id)
    }
  end

  def self.permissions_by_ids(permission_ids)
    ids = permission_ids&.map(&:to_i)
    permissions.select { |p| ids&.include?(p[:id]) }
  end

  def self.special_permissions_by_ids(permission_ids)
    ids = permission_ids&.map(&:to_sym)
    permissions.select { |p| ids&.include?(p[:id]) }
  end

  def self.generate_user_permissions(data) # rubocop:disable Metrics/AbcSize
    user_uniq_permissions = data.map(&:permissions).flatten.uniq
    special_permissions = user_uniq_permissions.filter { |p| p['target_type'] == 'special' }
    permission_ids = special_permissions.map { |p| map_special_permission[p['id'].to_sym] }.flatten
    without_special_permissions = permissions_by_ids(permission_ids)
    grouped_by_target = without_special_permissions.group_by { |role| role[:target_name] }

    combined_roles_by_target = {}

    grouped_by_target.each do |target_type, roles_array|
      combined_roles = {}
      allowed_routes ||= []
      roles_array.each do |role|
        access_type = role[:access_type]
        combined_roles[access_type] ||= []
        allowed_routes << role[:allowed_routes] if role[:allowed_routes].present?

        if role[:access_for].is_a?(Array)
          combined_roles[access_type].concat(role[:access_for])
        else
          combined_roles[access_type] << role[:access_for]
        end
      end

      combined_roles[:allowed_routes] = allowed_routes.flatten

      combined_roles.each do |key, value|
        combined_roles[key] = value.uniq
      end

      combined_roles_by_target[target_type] = combined_roles
    end

    combined_roles_by_target.each_value do |v|
      v['deny'] = [] unless v.key?('deny')
      v['grant'] = [] if v.key?('deny') && v['deny']&.include?('all')
      v['grant'] = ['all'] if v.key?('grant') && v['grant']&.include?('all')
    end
  end

end
