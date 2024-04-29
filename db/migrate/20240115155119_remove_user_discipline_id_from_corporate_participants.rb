class RemoveUserDisciplineIdFromCorporateParticipants < ActiveRecord::Migration[6.0]
  def change
    remove_column :corporate_participants, :user_discipline_id
  end
end
