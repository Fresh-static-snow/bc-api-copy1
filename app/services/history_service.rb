# frozen_string_literal: true

class HistoryService

  class << self

    def recover_history(resource)
      deleted_item = DeletedItem.where(cast_item_type: resource.model_name.name, cast_item_id: resource.id).last
      MatchCast.with_deleted.where(id: deleted_item.match_cast_ids)
               .update_all(association_key(resource) => resource.id) # rubocop:disable Rails/SkipsModelValidations

      deleted_item.destroy
    end

    def hide_history(resource, soft_destroy: false)
      if soft_destroy
        DeletedItem.create!(cast_item_type: resource.model_name.name, cast_item_id: resource.id,
                            match_cast_ids: resource.match_casts.ids)
      end
      MatchCast.with_deleted.where(association_key(resource) => resource.id)
               .update_all(association_key(resource) => nil) # rubocop:disable Rails/SkipsModelValidations
    end

    def association_key(resource)
      resource.association(:match_casts).reflection.foreign_key
    end

  end

end
