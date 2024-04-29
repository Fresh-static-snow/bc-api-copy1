# frozen_string_literal: true

module ArchivedCover

  def archived_cover(t)
    ArchivedImageResource.where(
      item_type: t.class.name,
      item_id: t.id,
      item_column: :cover
    ).last
  end

  def recover_cover(t)
    ac = archived_cover(t)
    t.reload.cover.attach(ac.resource.blob)
    ac.destroy
  end

  def cache_cover(t)
    ArchivedImageResource.create!(
      item_type: t.class.name,
      item_id: t.id,
      item_column: :cover,
      resource: t.cover.blob
    )
  end

end
