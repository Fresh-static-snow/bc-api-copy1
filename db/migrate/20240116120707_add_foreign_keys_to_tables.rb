class AddForeignKeysToTables < ActiveRecord::Migration[6.0]
  def change

    EntityComment.with_deleted.map do |comment|
      comment.destroy_fully! unless comment.user.present?
    end

    add_foreign_key :corporate_main_participants, :corporates, null: false
    add_foreign_key :corporate_main_participants, :users, null: false

    add_foreign_key :corporate_participants, :corporates, null: false
    add_foreign_key :corporate_participants, :users, null: false

    add_foreign_key :corporates, :corporate_companies, column: :company_id, null: false

    add_foreign_key :entity_comments, :users, null: false

    add_foreign_key :match_analytics, :match_casts, null: false
    add_foreign_key :match_analytics, :users, null: false
    add_foreign_key :match_analytics, :tournaments, null: false

    add_foreign_key :match_commentators, :match_casts, null: false
    add_foreign_key :match_commentators, :users, null: false
    add_foreign_key :match_commentators, :tournaments, null: false

    add_foreign_key :match_staff_members, :match_casts, null: false
    add_foreign_key :match_staff_members, :users, null: false
    add_foreign_key :match_staff_members, :tournaments, null: false

    add_foreign_key :match_casts, :matches, null: false
    add_foreign_key :match_casts, :cast_languages, null: true
    add_foreign_key :match_casts, :cast_studios, null: true
    add_foreign_key :match_casts, :cast_analytic_studios, null: true

    add_foreign_key :matches, :tournaments, null: false
    add_foreign_key :matches, :teams, column: :team_one_id, null: true
    add_foreign_key :matches, :teams, column: :team_two_id, null: true

    add_foreign_key :tournament_descriptions, :tournaments, null: false

    add_foreign_key :tournament_main_participants, :tournaments, null: false
    add_foreign_key :tournament_main_participants, :users, null: false

    add_foreign_key :tournament_media, :tournaments, null: false

    add_foreign_key :tournament_media_representatives, :tournaments, null: false
    add_foreign_key :tournament_media_representatives, :users, null: false

    add_foreign_key :tournament_sponsors, :tournaments, null: false
    add_foreign_key :tournament_sponsors, :tournament_sponsors, column: :sponsor_id, null: false

    add_foreign_key :tournaments, :regions, null: true
    add_foreign_key :tournaments, :tournament_types, column: :type_id, null: true
    add_foreign_key :tournaments, :users,column: :owner_id, null: true
    add_foreign_key :tournaments, :game_disciplines, null: false

    add_foreign_key :user_notifications, :users, null: false
    add_foreign_key :user_notifications, :users, column: :author_id, null: false

    add_foreign_key :users, :user_companies, column: :company_id, null: false
  end
end
