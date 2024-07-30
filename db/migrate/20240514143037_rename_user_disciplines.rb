class RenameUserDisciplines < ActiveRecord::Migration[6.0]
  def change
    UserDiscipline.find_by(title: 'Analytic')&.update_column(:title, 'Analyst')
    UserDiscipline.find_by(title: 'Commentator')&.update_column(:title, 'Caster')
  end
end
