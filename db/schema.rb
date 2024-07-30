# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_07_17_130049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "current_user_filter_enabled", default: true
    t.integer "default_calendar_scope", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_account_settings_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "archived_image_resources", force: :cascade do |t|
    t.string "item_type"
    t.integer "item_id"
    t.string "item_column"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "brandings", force: :cascade do |t|
    t.string "name"
    t.boolean "visible", default: false, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_brandings_on_deleted_at"
  end

  create_table "cast_analytic_studios", force: :cascade do |t|
    t.string "name"
    t.string "keyword"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cast_analytic_studios_on_deleted_at"
  end

  create_table "cast_channels", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cast_channels_on_deleted_at"
  end

  create_table "cast_languages", force: :cascade do |t|
    t.string "name"
    t.string "keyword"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cast_languages_on_deleted_at"
  end

  create_table "cast_setups", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_cast_setups_on_deleted_at"
  end

  create_table "cast_streams", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_cast_streams_on_deleted_at"
  end

  create_table "cast_studios", force: :cascade do |t|
    t.string "name"
    t.string "keyword"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cast_studios_on_deleted_at"
  end

  create_table "corporate_companies", force: :cascade do |t|
    t.string "title", null: false
    t.string "keyword", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_corporate_companies_on_deleted_at"
  end

  create_table "corporate_main_participants", force: :cascade do |t|
    t.integer "corporate_id", null: false
    t.integer "user_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_corporate_main_participants_on_deleted_at"
  end

  create_table "corporate_participants", force: :cascade do |t|
    t.integer "corporate_id", null: false
    t.integer "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_corporate_participants_on_deleted_at"
  end

  create_table "corporates", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "visible", default: false, null: false
    t.string "location"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text "description"
    t.datetime "deleted_at"
    t.integer "company_id"
    t.jsonb "ui_template", default: {}
    t.index ["deleted_at"], name: "index_corporates_on_deleted_at"
  end

  create_table "deleted_items", force: :cascade do |t|
    t.integer "cast_item_id"
    t.string "cast_item_type"
    t.integer "match_cast_ids", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "segment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entity_comments", force: :cascade do |t|
    t.string "entity_type"
    t.text "message"
    t.integer "user_id"
    t.integer "entity_id"
    t.datetime "created_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_entity_comments_on_deleted_at"
  end

  create_table "game_disciplines", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "deleted_at"
    t.integer "order", default: 0
    t.string "keyword"
    t.index ["deleted_at"], name: "index_game_disciplines_on_deleted_at"
  end

  create_table "guests", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "social"
    t.bigint "segment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email", null: false
    t.integer "created_by_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "token", null: false
    t.integer "status", default: 0
    t.index ["deleted_at"], name: "index_invitations_on_deleted_at"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "match_analytics", force: :cascade do |t|
    t.integer "match_cast_id"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.integer "tournament_id"
    t.index ["deleted_at"], name: "index_match_analytics_on_deleted_at"
    t.index ["match_cast_id", "user_id"], name: "index_match_analytics_on_match_cast_id_and_user_id", unique: true
  end

  create_table "match_backup_commentators", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "match_cast_id"
    t.bigint "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_match_backup_commentators_on_deleted_at"
    t.index ["match_cast_id"], name: "index_match_backup_commentators_on_match_cast_id"
    t.index ["user_id"], name: "index_match_backup_commentators_on_user_id"
  end

  create_table "match_casts", force: :cascade do |t|
    t.integer "match_id"
    t.integer "cast_language_id"
    t.integer "cast_studio_id"
    t.datetime "deleted_at"
    t.integer "cast_analytic_studio_id"
    t.integer "host_analytic_id"
    t.integer "backup_commentator_id"
    t.integer "cast_setup_id"
    t.integer "cast_stream_id"
    t.index ["deleted_at"], name: "index_match_casts_on_deleted_at"
    t.index ["match_id"], name: "index_match_casts_on_match_id"
  end

  create_table "match_casts_channels", force: :cascade do |t|
    t.bigint "match_cast_id"
    t.bigint "channel_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_match_casts_channels_on_deleted_at"
  end

  create_table "match_commentators", force: :cascade do |t|
    t.integer "match_cast_id"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.integer "tournament_id"
    t.index ["deleted_at"], name: "index_match_commentators_on_deleted_at"
    t.index ["match_cast_id", "user_id"], name: "index_match_commentators_on_match_cast_id_and_user_id", unique: true
  end

  create_table "match_host_analytics", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "match_cast_id"
    t.bigint "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_match_host_analytics_on_deleted_at"
    t.index ["match_cast_id"], name: "index_match_host_analytics_on_match_cast_id"
    t.index ["user_id"], name: "index_match_host_analytics_on_user_id"
  end

  create_table "match_staff_members", force: :cascade do |t|
    t.integer "match_cast_id"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.integer "tournament_id"
    t.index ["deleted_at"], name: "index_match_staff_members_on_deleted_at"
    t.index ["match_cast_id", "user_id"], name: "index_match_staff_members_on_match_cast_id_and_user_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.boolean "visible", default: false, null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "best_of"
    t.integer "tournament_id"
    t.integer "team_one_id"
    t.integer "team_two_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.jsonb "google_event_ids", default: {}
    t.string "type"
    t.string "title"
    t.index ["deleted_at"], name: "index_matches_on_deleted_at"
  end

  create_table "media", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "segment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.string "code"
    t.index ["deleted_at"], name: "index_regions_on_deleted_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "deleted_at"
    t.string "description"
    t.jsonb "permissions", default: {}
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "match_duration", default: 60
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sign_up_requests", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_sign_up_requests_on_deleted_at"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_sponsors_on_deleted_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "keyword"
    t.integer "game_discipline_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_teams_on_deleted_at"
  end

  create_table "tournament_descriptions", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_descriptions_on_deleted_at"
  end

  create_table "tournament_main_participants", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "user_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_main_participants_on_deleted_at"
    t.index ["tournament_id", "user_id"], name: "index_tournament_main_participants_on_t_id_and_u_id", unique: true
  end

  create_table "tournament_media", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_media_on_deleted_at"
  end

  create_table "tournament_media_representatives", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "user_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_media_representatives_on_deleted_at"
    t.index ["tournament_id", "user_id"], name: "index_tournament_media_representatives_on_t_id_and_u_id", unique: true
  end

  create_table "tournament_sponsors", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "sponsor_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_sponsors_on_deleted_at"
  end

  create_table "tournament_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tournament_types_on_deleted_at"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "visible", default: false, null: false
    t.date "start_at"
    t.date "end_at"
    t.integer "region_id"
    t.integer "type_id"
    t.integer "owner_id"
    t.integer "game_discipline_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.jsonb "ui_template", default: {}
    t.integer "top", default: 3, null: false
    t.index ["deleted_at"], name: "index_tournaments_on_deleted_at"
  end

  create_table "user_api_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.text "access_token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_api_tokens_on_deleted_at"
    t.index ["user_id"], name: "index_user_api_tokens_on_user_id"
  end

  create_table "user_companies", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_companies_on_deleted_at"
  end

  create_table "user_discipline_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "user_discipline_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_discipline_memberships_on_deleted_at"
    t.index ["user_discipline_id"], name: "index_user_discipline_memberships_on_user_discipline_id"
    t.index ["user_id", "user_discipline_id"], name: "index_user_discipline_memberships_uniqueness", unique: true
    t.index ["user_id"], name: "index_user_discipline_memberships_on_user_id"
  end

  create_table "user_disciplines", force: :cascade do |t|
    t.string "title"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_disciplines_on_deleted_at"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "seen", default: false
    t.integer "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "author_id"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.string "entity_action"
    t.boolean "personal"
    t.index ["deleted_at"], name: "index_user_notifications_on_deleted_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_roles_on_deleted_at"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_uniqueness", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.boolean "confirmed", default: false
    t.boolean "deactivated", default: false
    t.string "nick"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "company_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "hide_history", default: false
    t.boolean "google_calendar_required", default: false, null: false
    t.boolean "google_calendar_status", default: false, null: false
    t.string "display_name"
    t.string "time_zone", default: "Europe/Kiev"
    t.integer "telegram_chat_id"
    t.bigint "discord_user_id"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_settings", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "corporate_main_participants", "corporates"
  add_foreign_key "corporate_main_participants", "users"
  add_foreign_key "corporate_participants", "corporates"
  add_foreign_key "corporate_participants", "users"
  add_foreign_key "corporates", "corporate_companies", column: "company_id"
  add_foreign_key "entity_comments", "users"
  add_foreign_key "match_analytics", "match_casts"
  add_foreign_key "match_analytics", "tournaments"
  add_foreign_key "match_analytics", "users"
  add_foreign_key "match_casts", "cast_analytic_studios"
  add_foreign_key "match_casts", "cast_languages"
  add_foreign_key "match_casts", "cast_studios"
  add_foreign_key "match_casts", "matches"
  add_foreign_key "match_commentators", "match_casts"
  add_foreign_key "match_commentators", "tournaments"
  add_foreign_key "match_commentators", "users"
  add_foreign_key "match_staff_members", "match_casts"
  add_foreign_key "match_staff_members", "tournaments"
  add_foreign_key "match_staff_members", "users"
  add_foreign_key "matches", "teams", column: "team_one_id"
  add_foreign_key "matches", "teams", column: "team_two_id"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "tournament_descriptions", "tournaments"
  add_foreign_key "tournament_main_participants", "tournaments"
  add_foreign_key "tournament_main_participants", "users"
  add_foreign_key "tournament_media", "tournaments"
  add_foreign_key "tournament_media_representatives", "tournaments"
  add_foreign_key "tournament_media_representatives", "users"
  add_foreign_key "tournament_sponsors", "tournament_sponsors", column: "sponsor_id"
  add_foreign_key "tournament_sponsors", "tournaments"
  add_foreign_key "tournaments", "game_disciplines"
  add_foreign_key "tournaments", "regions"
  add_foreign_key "tournaments", "tournament_types", column: "type_id"
  add_foreign_key "tournaments", "users", column: "owner_id"
  add_foreign_key "user_api_tokens", "users"
  add_foreign_key "user_discipline_memberships", "user_disciplines"
  add_foreign_key "user_discipline_memberships", "users"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "user_notifications", "users", column: "author_id"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "user_companies", column: "company_id"
end
