# frozen_string_literal: true

class BaseCrudController < ApplicationController

  def index
    authorize resource_class

    data = resource_class::List.call(search_params)
    render_json_response(true, data, :ok)
  end

  def show
    authorize resource

    data = resource_class::Show.call(resource)
    render_json_response(true, data, :ok)
  end

  def create
    authorize resource_class

    data = resource_class::Create.call(resource_params)
    handle_entity_result(data, :ok)
  end

  def edit
    authorize resource

    data = resource_class::Edit.call(resource)
    render_json_response(true, data, :ok)
  end

  def update
    authorize resource

    data = resource_class::Update.call(resource, resource_params)
    handle_entity_result(data, :ok)
  end

  def destroy
    authorize deleted_resource

    data = resource_class::Delete.call(deleted_resource)
    handle_entity_result(data, :ok)
  end

  def soft_destroy
    authorize resource

    data = resource_class::SoftDestroy.call(resource)
    render_json_response(true, data, :ok)
  end

  def restore
    authorize deleted_resource

    data = resource_class::Restore.call(deleted_resource)
    render_json_response(true, data, :ok)
  end

  private

  def resource_class; end

  def resource
    @resource = resource_class.find(params[:id])
  end

  def deleted_resource
    @deleted_resource = resource_class.only_deleted.find(params[:id])
  end

  def search_params; end

  def resource_params; end

end
