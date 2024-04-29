# frozen_string_literal: true

module DeletedContext

  def only_deleted?
    ManagementContext::Items::DeletedItems::AVAILABLE_SCOPES.include?(params[:scope])
  end

  def deleted_resource
    ManagementContext::Items::DeletedItems.call(resource_class)
  end

  def scope
    params[:with_history] == 'true' ? :with_history : :list
  end

end
