# frozen_string_literal: true

module PermissionScheme

  extend ActiveSupport::Concern

  CREATE = :create
  EDIT   = :edit
  VIEW   = :view
  DELETE = :delete

  PERMISSIONS_MAP = {}.with_indifferent_access.freeze

end
