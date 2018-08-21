# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180820142901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "african_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_african_codes_on_code"
  end

  create_table "classification_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_classification_codes_on_code"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "contact_type"
    t.string "value"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_contacts_on_profile_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "number", default: "", null: false
    t.string "alpha2code", default: "", null: false
    t.string "alpha3code", default: "", null: false
    t.string "name", default: "", null: false
    t.string "world_region", default: "", null: false
    t.string "world_subregion", default: "", null: false
    t.jsonb "other_names", default: {}, null: false
    t.bigint "currencies_id"
    t.bigint "world_regions_id"
    t.index ["alpha2code"], name: "index_countries_on_alpha2code", unique: true
    t.index ["alpha3code"], name: "index_countries_on_alpha3code", unique: true
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["currencies_id"], name: "index_countries_on_currencies_id"
    t.index ["name"], name: "index_countries_on_name"
    t.index ["number"], name: "index_countries_on_number"
    t.index ["world_regions_id"], name: "index_countries_on_world_regions_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "code", default: "", null: false
    t.string "unit"
    t.index ["code"], name: "index_currencies_on_code"
    t.index ["name"], name: "index_currencies_on_name"
  end

  create_table "gsin_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_gsin_codes_on_code"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name", default: "", null: false
  end

  create_table "industry_codes", force: :cascade do |t|
    t.string "entity_code_name", default: "", null: false
    t.integer "entity_code_id", default: 0, null: false
    t.bigint "industry_id"
    t.index ["industry_id"], name: "index_industry_codes_on_industry_id"
  end

  create_table "ngip_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_ngip_codes_on_code"
  end

  create_table "nigp_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_nigp_codes_on_code"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "fullname"
    t.string "display_name"
    t.string "company"
    t.string "timezone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "registration_requests", force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "company", default: "", null: false
    t.integer "company_size", default: 0, null: false
    t.string "state", default: "", null: false
    t.string "country", default: "", null: false
    t.string "city", default: "", null: false
    t.string "sector"
    t.integer "turnover", default: 0, null: false
    t.json "markets", default: {}, null: false
    t.integer "tender_level", default: 0, null: false
    t.float "win_rate", default: 0.0, null: false
    t.integer "number_public_contracts", default: 0, null: false
    t.boolean "do_use_automation", default: false, null: false
    t.boolean "do_use_collaboration", default: false, null: false
    t.boolean "do_use_bid_no_bid", default: false, null: false
    t.boolean "do_use_bid_library", default: false, null: false
    t.boolean "do_use_feedback", default: false, null: false
    t.boolean "do_collaborate", default: false, null: false
    t.float "tender_complete_time", default: 0.0, null: false
    t.integer "organisation_count", default: 0, null: false
    t.boolean "do_processed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.bigint "industry_id"
    t.index ["country_id"], name: "index_registration_requests_on_country_id"
    t.index ["industry_id"], name: "index_registration_requests_on_industry_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "search_monitors", force: :cascade do |t|
    t.string "title"
    t.string "tenderTitle"
    t.integer "countryList", default: [], array: true
    t.string "keywordList", default: [], array: true
    t.integer "valueFrom"
    t.integer "valueTo"
    t.integer "codeList", default: [], array: true
    t.integer "buyerList", default: [], array: true
    t.integer "statusList", default: [], array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_search_monitors_on_user_id"
  end

  create_table "sfgov_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_sfgov_codes_on_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "world_regions", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "name", default: "", null: false
  end

  add_foreign_key "contacts", "profiles"
  add_foreign_key "countries", "currencies", column: "currencies_id"
  add_foreign_key "countries", "world_regions", column: "world_regions_id"
  add_foreign_key "industry_codes", "industries"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "registration_requests", "countries"
  add_foreign_key "registration_requests", "industries"
  add_foreign_key "search_monitors", "users"
end
