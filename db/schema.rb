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

ActiveRecord::Schema.define(version: 20180918151146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliases", id: :serial, force: :cascade do |t|
    t.string "original_name", limit: 255, null: false
    t.string "alias_name", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "regexp", default: false, null: false
    t.string "type", limit: 255, null: false
    t.index ["alias_name"], name: "index_aliases_on_alias_name"
    t.index ["original_name"], name: "index_aliases_on_original_name"
  end

  create_table "analyzed_notices", id: :serial, force: :cascade do |t|
    t.integer "notice_id", null: false
    t.integer "reduced_notice_id"
    t.string "title", limit: 4096, null: false
    t.string "authority_name", limit: 4096, null: false
    t.string "authority_email", limit: 255
    t.string "country_name", limit: 255, null: false
    t.string "status_name", limit: 255
    t.text "analyzed_attributes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_merged", default: false, null: false
    t.datetime "merged_at"
    t.string "type_name", limit: 255, null: false
    t.boolean "disabled", default: false, null: false
    t.string "error_messages", limit: 4096
    t.string "file_reference_number", limit: 255
    t.index ["authority_email"], name: "index_analyzed_notices_on_authority_email"
    t.index ["authority_name"], name: "index_analyzed_notices_on_authority_name"
    t.index ["country_name"], name: "index_analyzed_notices_on_country_name"
    t.index ["notice_id"], name: "index_analyzed_notices_on_notice_id"
    t.index ["reduced_notice_id"], name: "index_analyzed_notices_on_reduced_notice_id"
    t.index ["title"], name: "index_analyzed_notices_on_title"
  end

  create_table "assistances", force: :cascade do |t|
    t.integer "assistance_type"
    t.text "message"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_assistances_on_user_id"
  end

  create_table "attached_files", force: :cascade do |t|
    t.string "filename"
    t.string "file_type"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "file"
    t.string "content_type"
    t.string "file_size"
  end

  create_table "attachments_core_tenders", id: false, force: :cascade do |t|
    t.bigint "attachment_id"
    t.bigint "tender_id"
    t.index ["attachment_id"], name: "index_attachments_core_tenders_on_attachment_id"
    t.index ["tender_id"], name: "index_attachments_core_tenders_on_tender_id"
  end

  create_table "bidsense_results", force: :cascade do |t|
    t.float "budget"
    t.float "geography"
    t.float "subject"
    t.float "incumbent"
    t.float "time"
    t.float "buyer_related"
    t.bigint "profile_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "result"
    t.float "average_score"
    t.index ["profile_id"], name: "index_bidsense_results_on_profile_id"
    t.index ["tender_id"], name: "index_bidsense_results_on_tender_id"
  end

  create_table "case_studies", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "cover_img"
    t.float "budget", default: 0.0, null: false
    t.string "video_list", default: [], array: true
    t.datetime "start_date"
    t.datetime "delivery_date"
    t.boolean "archived", default: false, null: false
    t.bigint "profile_id"
    t.index ["profile_id"], name: "index_case_studies_on_profile_id"
  end

  create_table "case_studies_galleries", id: false, force: :cascade do |t|
    t.bigint "gallery_id"
    t.bigint "case_study_id"
    t.index ["case_study_id"], name: "index_case_studies_galleries_on_case_study_id"
    t.index ["gallery_id"], name: "index_case_studies_galleries_on_gallery_id"
  end

  create_table "case_studies_industry_codes", id: false, force: :cascade do |t|
    t.bigint "industry_code_id"
    t.bigint "case_study_id"
    t.index ["case_study_id"], name: "index_case_studies_industry_codes_on_case_study_id"
    t.index ["industry_code_id"], name: "index_case_studies_industry_codes_on_industry_code_id"
  end

  create_table "collaboration_interests", force: :cascade do |t|
    t.text "message"
    t.boolean "is_public"
    t.bigint "user_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_collaboration_interests_on_tender_id"
    t.index ["user_id"], name: "index_collaboration_interests_on_user_id"
  end

  create_table "collaborations", force: :cascade do |t|
    t.bigint "tender_id"
    t.index ["tender_id"], name: "index_collaborations_on_tender_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "role"
    t.bigint "user_id"
    t.bigint "collaboration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaboration_id"], name: "index_collaborators_on_collaboration_id"
    t.index ["user_id"], name: "index_collaborators_on_user_id"
  end

  create_table "compete_answers", force: :cascade do |t|
    t.text "message", null: false
    t.integer "parent_id"
    t.bigint "user_id"
    t.bigint "compete_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compete_comment_id"], name: "index_compete_answers_on_compete_comment_id"
    t.index ["user_id"], name: "index_compete_answers_on_user_id"
  end

  create_table "compete_comments", force: :cascade do |t|
    t.text "message", null: false
    t.integer "parent_id"
    t.bigint "user_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_compete_comments_on_tender_id"
    t.index ["user_id"], name: "index_compete_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "contact_type"
    t.string "value"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_additional_information", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "url", limit: 4096, null: false
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tender_id"], name: "index_core_additional_information_on_tender_id"
    t.index ["title"], name: "index_core_additional_information_on_title"
  end

  create_table "core_affiliate_feed_trackers", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "search_id", null: false
    t.integer "ref_id", null: false
    t.string "ip_address", limit: 255, null: false
    t.string "remote_url", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ref_id"], name: "index_core_affiliate_feed_trackers_on_ref_id"
    t.index ["search_id"], name: "index_core_affiliate_feed_trackers_on_search_id"
    t.index ["tender_id"], name: "index_core_affiliate_feed_trackers_on_tender_id"
  end

  create_table "core_african_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_african_codes_on_code"
  end

  create_table "core_analyzed_tenders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "tender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_api_credentials", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token", limit: 255, null: false
  end

  create_table "core_awards", id: :serial, force: :cascade do |t|
    t.string "lot_title", limit: 4096, null: false
    t.string "lot_number", limit: 255
    t.date "awarded_on", null: false
    t.string "contract_number", limit: 255
    t.integer "offers_count"
    t.decimal "value", precision: 16, scale: 2
    t.integer "tender_id", null: false
    t.integer "organization_id", null: false
    t.integer "contact_id"
    t.index ["contact_id"], name: "index_core_awards_on_contact_id"
    t.index ["organization_id"], name: "index_core_awards_on_organization_id"
    t.index ["tender_id"], name: "index_core_awards_on_tender_id"
  end

  create_table "core_bid_question_templates", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.boolean "disabled", default: false, null: false
    t.boolean "default", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_core_bid_question_templates_on_name", unique: true
  end

  create_table "core_bid_questions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.string "category", limit: 255, null: false
    t.integer "template_id", null: false
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_core_bid_questions_on_name"
    t.index ["template_id", "name"], name: "index_core_bid_questions_on_template_id_and_name", unique: true
  end

  create_table "core_campaigns", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "owner", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "records_exported", limit: 255
    t.string "industry", limit: 255
  end

  create_table "core_categories", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_categories_on_code"
  end

  create_table "core_cities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "index_core_cities_on_country_id"
    t.index ["name"], name: "index_core_cities_on_name"
  end

  create_table "core_classification_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_classification_codes_on_code"
  end

  create_table "core_comments", id: :serial, force: :cascade do |t|
    t.text "commentary", null: false
    t.integer "creator_id", null: false
    t.integer "analyzed_tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_contacts", id: :serial, force: :cascade do |t|
    t.string "phone", limit: 255
    t.string "fax", limit: 255
    t.string "address", limit: 4096
    t.string "email", limit: 255
    t.string "contact_point", limit: 255
    t.string "city_name", limit: 255
    t.integer "region_id"
    t.integer "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "postcode", limit: 255
    t.boolean "delta", default: true, null: false
    t.integer "creator_id"
    t.string "linked_in", limit: 255
    t.string "salesforce_id", limit: 255
    t.string "assistant", limit: 255
    t.string "asst_phone", limit: 255
    t.string "department", limit: 255
    t.string "description", limit: 255
    t.boolean "do_not_call"
    t.boolean "email_opt_out"
    t.boolean "fax_opt_out"
    t.string "lead_source", limit: 255
    t.string "mobile", limit: 255
    t.string "title", limit: 255
    t.string "other_address", limit: 255
    t.string "other_phone", limit: 255
    t.index ["address"], name: "index_core_address"
    t.index ["contact_point"], name: "index_core_contact_point"
    t.index ["email"], name: "index_core_email"
    t.index ["organization_id"], name: "index_core_contacts_on_organization_id"
    t.index ["phone"], name: "index_core_phone"
    t.index ["region_id"], name: "index_core_contacts_on_region_id"
  end

  create_table "core_countries", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255
    t.string "number", limit: 255, null: false
    t.string "alpha2code", limit: 255, null: false
    t.string "alpha3code", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "world_region", limit: 255
    t.string "world_subregion", limit: 255, null: false
    t.string "other_names", limit: 255, default: [], array: true
    t.integer "currency_id"
    t.integer "world_region_id"
    t.index ["alpha2code"], name: "index_core_countries_on_alpha2code"
    t.index ["alpha3code"], name: "index_core_countries_on_alpha3code"
    t.index ["code"], name: "index_core_countries_on_code"
    t.index ["currency_id"], name: "index_core_countries_on_currency_id"
    t.index ["name", "alpha2code"], name: "index_core_countries_on_name_and_alpha2code"
    t.index ["name", "alpha3code"], name: "index_core_countries_on_name_and_alpha3code"
    t.index ["name"], name: "index_core_countries_on_name"
    t.index ["number"], name: "index_core_countries_on_number"
    t.index ["other_names"], name: "index_core_countries_on_other_names", using: :gin
    t.index ["world_region_id"], name: "index_core_countries_on_world_region_id"
  end

  create_table "core_countries_profiles", id: false, force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "profile_id"
    t.index ["country_id"], name: "index_core_countries_profiles_on_country_id"
    t.index ["profile_id"], name: "index_core_countries_profiles_on_profile_id"
  end

  create_table "core_cpvs", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_cpvs_on_code"
  end

  create_table "core_currencies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "code", limit: 255, null: false
    t.string "unit", limit: 255
    t.index ["code"], name: "index_core_currencies_on_code", unique: true
    t.index ["name"], name: "index_core_currencies_on_name"
  end

  create_table "core_documents", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "url", limit: 4096, null: false
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tender_id"], name: "index_core_documents_on_tender_id"
    t.index ["title"], name: "index_core_documents_on_title"
  end

  create_table "core_feed_requests", id: :serial, force: :cascade do |t|
    t.integer "creator_id", null: false
    t.integer "search_id", null: false
    t.integer "opportunities_count", default: 0
    t.string "ip_address", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_core_feed_requests_on_created_at"
    t.index ["creator_id"], name: "index_core_feed_requests_on_creator_id"
    t.index ["search_id"], name: "index_core_feed_requests_on_search_id"
  end

  create_table "core_groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "domain", limit: 255, default: "", null: false
    t.integer "organization_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.index ["domain"], name: "index_core_groups_on_domain", unique: true
    t.index ["name"], name: "index_core_groups_on_name", unique: true
  end

  create_table "core_gsin_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_gsin_codes_on_code"
  end

  create_table "core_guest_users", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "job_title", limit: 255, null: false
    t.string "company", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "phone", limit: 255, null: false
    t.string "type", limit: 255
  end

  create_table "core_languages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "iso_639_2", limit: 255, null: false
    t.index ["id"], name: "index_core_languages_on_id"
  end

  create_table "core_lots", id: :serial, force: :cascade do |t|
    t.string "title", limit: 4096, null: false
    t.string "number", limit: 255
    t.decimal "estimated_value", precision: 16, scale: 2
    t.decimal "estimated_low_value", precision: 16, scale: 2
    t.decimal "estimated_high_value", precision: 16, scale: 2
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tender_id"], name: "index_core_lots_on_tender_id"
  end

  create_table "core_naicses", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_naicses_on_code"
  end

  create_table "core_ngip_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_ngip_codes_on_code"
  end

  create_table "core_nhs_e_classes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 300, null: false
    t.index ["code"], name: "index_core_nhs_e_classes_on_code"
  end

  create_table "core_nigp_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_nigp_codes_on_code"
  end

  create_table "core_organization_profiles", id: :serial, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.string "phone", limit: 255
    t.string "fax", limit: 255
    t.string "email", limit: 255
    t.string "address", limit: 255
    t.string "postcode", limit: 255
    t.integer "city_id"
    t.integer "region_id"
    t.integer "published_tenders_count"
    t.integer "awarded_tenders_count"
    t.index ["city_id"], name: "index_core_organization_profiles_on_city_id"
    t.index ["organization_id"], name: "index_core_organization_profiles_on_organization_id", unique: true
    t.index ["region_id"], name: "index_core_organization_profiles_on_region_id"
  end

  create_table "core_organizations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "profile_url", limit: 4096
    t.string "web_url", limit: 4096
    t.integer "country_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "published_tenders_count", default: 0, null: false
    t.integer "awarded_tenders_count", default: 0, null: false
    t.integer "awards_count", default: 0, null: false
    t.boolean "delta", default: true, null: false
    t.string "email", limit: 255
    t.string "address", limit: 4096
    t.string "city_name", limit: 255
    t.string "phone", limit: 255
    t.string "fax", limit: 255
    t.integer "region_id"
    t.integer "creator_id"
    t.string "salesforce_id", limit: 255
    t.string "salesforce_number", limit: 255
    t.string "salesforce_source", limit: 255
    t.decimal "salesforce_revenue", precision: 18
    t.integer "employees"
    t.string "industry", limit: 255
    t.string "ownership", limit: 255
    t.string "rating", limit: 255
    t.string "sic_description", limit: 255
    t.string "sic_code", limit: 255
    t.string "salesforce_type", limit: 255
    t.string "ticker_symbol", limit: 255
    t.index ["awarded_tenders_count"], name: "index_core_awarded_tenders_count"
    t.index ["country_id"], name: "index_core_country_id"
    t.index ["country_id"], name: "index_core_organizations_on_country_id"
    t.index ["creator_id"], name: "index_core_creator_id"
    t.index ["name", "country_id", "creator_id"], name: "index_core_organizations_on_name_and_country_id_and_creator_id", unique: true
    t.index ["name"], name: "index_core_organizations_on_name"
    t.index ["published_tenders_count"], name: "index_core_published_tenders_count"
    t.index ["region_id"], name: "index_core_organizations_on_region_id"
    t.index ["web_url"], name: "index_core_web_url"
  end

  create_table "core_organizations_cpvs", id: :serial, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "cpv_id", null: false
    t.index ["cpv_id", "organization_id"], name: "index_core_organizations_cpvs_on_cpv_id_and_organization_id", unique: true
    t.index ["cpv_id"], name: "index_core_organizations_cpvs_on_cpv_id"
    t.index ["organization_id", "cpv_id"], name: "index_core_organizations_cpvs_on_organization_id_and_cpv_id", unique: true
    t.index ["organization_id"], name: "index_core_organizations_cpvs_on_organization_id"
  end

  create_table "core_organizations_naicses", id: :serial, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "naics_id", null: false
    t.index ["company_id", "naics_id"], name: "index_core_organizations_naicses_on_company_id_and_naics_id", unique: true
    t.index ["company_id"], name: "index_core_organizations_naicses_on_company_id"
    t.index ["naics_id", "company_id"], name: "index_core_organizations_naicses_on_naics_id_and_company_id", unique: true
    t.index ["naics_id"], name: "index_core_organizations_naicses_on_naics_id"
  end

  create_table "core_organizations_unspsces", id: :serial, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "unspsc_id", null: false
    t.index ["company_id", "unspsc_id"], name: "index_core_organizations_unspsces_on_company_id_and_unspsc_id", unique: true
    t.index ["company_id"], name: "index_core_organizations_unspsces_on_company_id"
    t.index ["unspsc_id", "company_id"], name: "index_core_organizations_unspsces_on_unspsc_id_and_company_id", unique: true
    t.index ["unspsc_id"], name: "index_core_organizations_unspsces_on_unspsc_id"
    t.index ["unspsc_id"], name: "index_core_unspsc_id"
  end

  create_table "core_pinned_items", id: :serial, force: :cascade do |t|
    t.string "type", limit: 255
    t.integer "user_id"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_pins", id: :serial, force: :cascade do |t|
    t.integer "pinnable_id"
    t.string "pinnable_type", limit: 255
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_posts", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "subtitle", limit: 255
    t.text "content"
    t.string "files", limit: 255, default: [], array: true
    t.string "tags", limit: 255, default: [], array: true
    t.boolean "published"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["files"], name: "index_core_posts_on_files", using: :gin
    t.index ["tags"], name: "index_core_posts_on_tags", using: :gin
  end

  create_table "core_pro_classes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 300, null: false
    t.index ["code"], name: "index_core_pro_classes_on_code"
  end

  create_table "core_procedures", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.index ["name"], name: "index_core_procedures_on_name", unique: true
  end

  create_table "core_questionaire", id: :serial, force: :cascade do |t|
    t.integer "score", default: 0
    t.integer "status_cd", default: 0
    t.integer "template_id", null: false
    t.integer "creator_id", null: false
    t.integer "tender_id", null: false
    t.integer "question_id", null: false
    t.text "note"
    t.index ["creator_id"], name: "index_core_questionaire_on_creator_id"
    t.index ["question_id"], name: "index_core_questionaire_on_question_id"
    t.index ["template_id"], name: "index_core_questionaire_on_template_id"
    t.index ["tender_id"], name: "index_core_questionaire_on_tender_id"
  end

  create_table "core_regions", id: :serial, force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "code", limit: 255
    t.string "region_type", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "other_names", limit: 255, default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_core_regions_on_code"
    t.index ["country_id", "name"], name: "index_core_regions_on_country_id_and_name", unique: true
    t.index ["country_id"], name: "index_core_regions_on_country_id"
    t.index ["name"], name: "index_core_regions_on_name"
    t.index ["other_names"], name: "index_core_regions_on_other_names", using: :gin
  end

  create_table "core_request_categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "description", limit: 255
    t.string "category_type", limit: 255
    t.string "ancestry", limit: 255
    t.decimal "threshold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.boolean "default", default: false
  end

  create_table "core_requested_award_initiator_details", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "initiator_id", null: false
    t.string "subject", limit: 255
    t.string "contacted_email", limit: 255
    t.boolean "tender_contact_available", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_requests", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.integer "category_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type", limit: 255
    t.integer "resource_id"
    t.integer "status_cd", default: 0, null: false
    t.integer "importance_cd", default: 0, null: false
    t.integer "urgency_cd", default: 0, null: false
    t.integer "confidentiality_cd", default: 0, null: false
    t.string "document_file_name", limit: 255
    t.string "document_content_type", limit: 255
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.text "comment_response"
  end

  create_table "core_responses", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.text "comment_clarify"
    t.string "document_file_name", limit: 255
    t.string "document_content_type", limit: 255
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.integer "status_cd", default: 0, null: false
    t.integer "request_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "document_name", limit: 255
  end

  create_table "core_roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.integer "number", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_core_roles_on_name", unique: true
  end

  create_table "core_saved_searches", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "description", null: false
    t.text "web_path", null: false
    t.text "options", null: false
    t.boolean "subscribed", default: false, null: false
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "search_type", limit: 255, null: false
    t.boolean "default_search", default: false
    t.integer "search_execution_count", default: 0
    t.boolean "send_awards_mail", default: false
    t.boolean "send_weekly_emails_only", default: false
    t.index ["name", "user_id"], name: "index_core_saved_searches_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_core_saved_searches_on_user_id"
  end

  create_table "core_sent_emails", id: :serial, force: :cascade do |t|
    t.string "mail_to", limit: 255
    t.string "domain_to", limit: 255
    t.string "mail_from", limit: 255
    t.string "type", limit: 255
    t.integer "relation_id"
    t.integer "status_cd", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_sessions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "searches_execution_count", default: 0
    t.datetime "sign_in_at"
    t.datetime "sign_out_at"
    t.index ["sign_in_at"], name: "index_core_sessions_on_sign_in_at"
    t.index ["sign_out_at"], name: "index_core_sessions_on_sign_out_at"
    t.index ["user_id"], name: "index_core_sessions_on_user_id"
  end

  create_table "core_sfgov_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_sfgov_codes_on_code"
  end

  create_table "core_system_email_subjects", id: :serial, force: :cascade do |t|
    t.string "subject", limit: 255, null: false
    t.integer "mail_from_id"
    t.boolean "mail_from_disabled", default: false
    t.integer "mail_to_id"
    t.boolean "mail_to_disabled", default: false
    t.integer "mail_cc_id"
    t.boolean "mail_cc_disabled", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["mail_cc_id"], name: "index_core_system_email_subjects_on_mail_cc_id"
    t.index ["mail_from_id"], name: "index_core_system_email_subjects_on_mail_from_id"
    t.index ["mail_to_id"], name: "index_core_system_email_subjects_on_mail_to_id"
  end

  create_table "core_system_emails", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "environment", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_tender_bids_templates", id: :serial, force: :cascade do |t|
    t.integer "creator_id", null: false
    t.boolean "selected", default: false
    t.integer "template_id", null: false
    t.integer "tender_id", null: false
    t.integer "threshold", default: 0
    t.index ["creator_id"], name: "index_core_tender_bids_templates_on_creator_id"
    t.index ["template_id"], name: "index_core_tender_bids_templates_on_template_id"
    t.index ["tender_id"], name: "index_core_tender_bids_templates_on_tender_id"
  end

  create_table "core_tender_personalized_requests", id: :serial, force: :cascade do |t|
    t.integer "creator_id", null: false
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_core_tender_personalized_requests_on_creator_id"
    t.index ["tender_id"], name: "index_core_tender_personalized_requests_on_tender_id"
  end

  create_table "core_tenders", id: :serial, force: :cascade do |t|
    t.string "title", limit: 4096, null: false
    t.text "description"
    t.datetime "published_on"
    t.date "awarded_on"
    t.datetime "submission_date"
    t.date "deadline_date"
    t.date "cancelled_on"
    t.integer "procedure_id"
    t.integer "currency_id"
    t.integer "organization_id"
    t.integer "status_cd"
    t.string "contract_authority_type", limit: 255
    t.string "main_activity", limit: 255
    t.string "contract_category", limit: 255
    t.string "location", limit: 255
    t.boolean "flagged_as_sme_friendly", default: false
    t.boolean "flagged_as_vcs_friendly", default: false
    t.string "nuts_codes", limit: 255, default: [], array: true
    t.string "supplementary_codes", limit: 255, default: [], array: true
    t.integer "contract_duration_in_days"
    t.integer "contract_duration_in_months"
    t.integer "contract_duration_in_years"
    t.date "contract_start_date"
    t.date "contract_end_date"
    t.decimal "award_value", precision: 16, scale: 2
    t.decimal "lowest_offer_value", precision: 16, scale: 2
    t.decimal "highest_offer_value", precision: 16, scale: 2
    t.integer "offers_count"
    t.decimal "estimated_value", precision: 16, scale: 2
    t.decimal "estimated_low_value", precision: 16, scale: 2
    t.decimal "estimated_high_value", precision: 16, scale: 2
    t.integer "framework_duration_in_days"
    t.integer "framework_duration_in_months"
    t.integer "framework_duration_in_years"
    t.decimal "framework_estimated_value", precision: 16, scale: 2
    t.numrange "framework_estimated_low_value"
    t.numrange "framework_estimated_high_value"
    t.string "keywords", limit: 255, default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "award_published_on"
    t.date "potential_retender_date"
    t.string "tender_urls", default: [], array: true
    t.string "award_urls", limit: 255, default: [], null: false, array: true
    t.string "spider_id"
    t.boolean "delta", default: true
    t.string "file_reference_number", limit: 255
    t.integer "creator_id"
    t.integer "naics_code_id"
    t.integer "classification_code_id"
    t.string "salesforce_id", limit: 255
    t.string "expected_revenue", limit: 255
    t.string "forecast_category", limit: 255
    t.string "last_modified_by", limit: 255
    t.string "lead_source", limit: 255
    t.string "next_step", limit: 255
    t.string "private", limit: 255
    t.string "probability", limit: 255
    t.string "quantity", limit: 255
    t.string "stage", limit: 255
    t.string "salesforce_type", limit: 255
    t.string "industry", limit: 255
    t.string "partner", limit: 255
    t.boolean "primary"
    t.string "role", limit: 255
    t.string "competitor", limit: 255
    t.string "strengths", limit: 255
    t.string "weaknesses", limit: 255
    t.string "set_aside", limit: 255
    t.string "archiving_policy", limit: 255
    t.date "archive_date"
    t.string "original_set_aside", limit: 255
    t.datetime "awarded_at"
    t.string "place_of_performance", limit: 1000
    t.boolean "request_awards", default: false
    t.boolean "retender_status", default: false
    t.datetime "dispatch_date"
    t.bigint "industry_id"
    t.integer "status", default: 0
    t.index ["awarded_on"], name: "index_core_awarded_on"
    t.index ["created_at"], name: "index_core_created_at"
    t.index ["flagged_as_sme_friendly"], name: "index_core_flagged_as_sme_friendly"
    t.index ["industry_id"], name: "index_core_tenders_on_industry_id"
    t.index ["offers_count"], name: "index_core_offers_count"
    t.index ["organization_id"], name: "index_core_tenders_on_organization_id"
    t.index ["procedure_id"], name: "index_core_tenders_on_procedure_id"
    t.index ["published_on"], name: "index_core_published_on"
    t.index ["spider_id"], name: "index_core_tenders_on_spider_id", unique: true
    t.index ["status_cd"], name: "index_core_status_cd"
    t.index ["submission_date"], name: "index_core_submission_datetime"
    t.index ["title"], name: "index_core_tenders_on_title"
    t.index ["updated_at"], name: "index_core_updated_at"
  end

  create_table "core_tenders_african_codes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "afr_code_id", null: false
    t.index ["afr_code_id", "tender_id"], name: "index_core_tenders_african_codes_on_afr_code_id_and_tender_id", unique: true
    t.index ["afr_code_id"], name: "index_core_tenders_african_codes_on_afr_code_id"
    t.index ["tender_id", "afr_code_id"], name: "index_core_tenders_african_codes_on_tender_id_and_afr_code_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_african_codes_on_tender_id"
  end

  create_table "core_tenders_categories", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id", "tender_id"], name: "index_core_tenders_categories_on_category_id_and_tender_id", unique: true
    t.index ["category_id"], name: "index_core_tenders_categories_on_category_id"
    t.index ["tender_id", "category_id"], name: "index_core_tenders_categories_on_tender_id_and_category_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_categories_on_tender_id"
  end

  create_table "core_tenders_contacts", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "contact_id", null: false
    t.index ["contact_id", "tender_id"], name: "index_core_tenders_contacts_on_contact_id_and_tender_id", unique: true
    t.index ["contact_id"], name: "index_core_tenders_contacts_on_contact_id"
    t.index ["tender_id", "contact_id"], name: "index_core_tenders_contacts_on_tender_id_and_contact_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_contacts_on_tender_id"
  end

  create_table "core_tenders_cpvs", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "cpv_id", null: false
    t.index ["cpv_id", "tender_id"], name: "index_core_tenders_cpvs_on_cpv_id_and_tender_id", unique: true
    t.index ["cpv_id"], name: "index_core_tenders_cpvs_on_cpv_id"
    t.index ["tender_id", "cpv_id"], name: "index_core_tenders_cpvs_on_tender_id_and_cpv_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_cpvs_on_tender_id"
  end

  create_table "core_tenders_gsin_codes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "gsin_id", null: false
    t.index ["gsin_id", "tender_id"], name: "index_core_tenders_gsin_codes_on_gsin_id_and_tender_id", unique: true
    t.index ["gsin_id"], name: "index_core_tenders_gsin_codes_on_gsin_id"
    t.index ["tender_id", "gsin_id"], name: "index_core_tenders_gsin_codes_on_tender_id_and_gsin_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_gsin_codes_on_tender_id"
  end

  create_table "core_tenders_naicses", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "naics_id", null: false
    t.index ["naics_id", "tender_id"], name: "index_core_tenders_naicses_on_naics_id_and_tender_id", unique: true
    t.index ["naics_id"], name: "index_core_tenders_naicses_on_naics_id"
    t.index ["tender_id", "naics_id"], name: "index_core_tenders_naicses_on_tender_id_and_naics_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_naicses_on_tender_id"
  end

  create_table "core_tenders_ngip_codes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "ngip_code_id", null: false
    t.index ["ngip_code_id", "tender_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id_and_tender_id", unique: true
    t.index ["ngip_code_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id"
    t.index ["tender_id", "ngip_code_id"], name: "index_core_tenders_ngip_codes_on_tender_id_and_ngip_code_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_ngip_codes_on_tender_id"
  end

  create_table "core_tenders_nhs_e_classes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "nhs_eclass_id", null: false
    t.index ["nhs_eclass_id", "tender_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id_and_tender_id", unique: true
    t.index ["nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id"
    t.index ["tender_id", "nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id_and_nhs_eclass_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id"
  end

  create_table "core_tenders_nigp_codes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "nigp_code_id", null: false
    t.index ["nigp_code_id", "tender_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id_and_tender_id", unique: true
    t.index ["nigp_code_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id"
    t.index ["tender_id", "nigp_code_id"], name: "index_core_tenders_nigp_codes_on_tender_id_and_nigp_code_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_nigp_codes_on_tender_id"
  end

  create_table "core_tenders_pro_classes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "pro_class_id", null: false
    t.index ["pro_class_id", "tender_id"], name: "index_core_tenders_pro_classes_on_pro_class_id_and_tender_id", unique: true
    t.index ["pro_class_id"], name: "index_core_tenders_pro_classes_on_pro_class_id"
    t.index ["tender_id", "pro_class_id"], name: "index_core_tenders_pro_classes_on_tender_id_and_pro_class_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_pro_classes_on_tender_id"
  end

  create_table "core_tenders_sfgov_codes", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "sfgov_id", null: false
    t.index ["sfgov_id", "tender_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id_and_tender_id", unique: true
    t.index ["sfgov_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id"
    t.index ["tender_id", "sfgov_id"], name: "index_core_tenders_sfgov_codes_on_tender_id_and_sfgov_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_sfgov_codes_on_tender_id"
  end

  create_table "core_tenders_unspsces", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "unspsc_id", null: false
    t.index ["tender_id", "unspsc_id"], name: "index_core_tenders_unspsces_on_tender_id_and_unspsc_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_unspsces_on_tender_id"
    t.index ["unspsc_id", "tender_id"], name: "index_core_tenders_unspsces_on_unspsc_id_and_tender_id", unique: true
    t.index ["unspsc_id"], name: "index_core_tenders_unspsces_on_unspsc_id"
  end

  create_table "core_tenders_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tender_id"
    t.index ["tender_id"], name: "index_core_tenders_users_on_tender_id"
    t.index ["user_id"], name: "index_core_tenders_users_on_user_id"
  end

  create_table "core_unspsces", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_unspsces_on_code"
  end

  create_table "core_user_countries", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "country_id", null: false
    t.integer "number_of_occurrences", default: 0
    t.index ["country_id"], name: "index_core_user_countries_on_country_id"
    t.index ["user_id"], name: "index_core_user_countries_on_user_id"
  end

  create_table "core_user_cpvs", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "cpv_id", null: false
    t.integer "number_of_occurrences", default: 0
    t.index ["cpv_id"], name: "index_core_user_cpvs_on_cpv_id"
    t.index ["user_id"], name: "index_core_user_cpvs_on_user_id"
  end

  create_table "core_user_naics", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "naics_id", null: false
    t.integer "number_of_occurrences", default: 0
    t.index ["naics_id"], name: "index_core_user_naics_on_naics_id"
    t.index ["user_id"], name: "index_core_user_naics_on_user_id"
  end

  create_table "core_users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.string "authentication_token", limit: 255
    t.integer "role_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "stripe_id", limit: 255
    t.string "plan_id", limit: 255
    t.date "end_subscription_date"
    t.boolean "enable_newsletters", default: true, null: false
    t.integer "group_id"
    t.integer "security_level_cd", default: 0, null: false
    t.string "temporary_token", limit: 255
    t.string "temporary_token_end_at", limit: 255
    t.boolean "schedule_for_follow_up", default: false
    t.string "service_delivery_manager", limit: 255
    t.date "date_of_last_follow_up"
    t.boolean "show_tenders", default: false
    t.boolean "show_contacts", default: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "company_name", limit: 255
    t.string "job_title", limit: 255
    t.string "company_size", limit: 255
    t.boolean "subscribe_newsletter", default: false
    t.string "keywords", limit: 255
    t.text "countries"
    t.string "plan", limit: 255
    t.string "phone", limit: 255
    t.string "vat_number", limit: 255
    t.integer "vat_percent", default: 0
    t.decimal "vat_amount", default: "0.0"
    t.integer "home_country_id"
    t.date "expiry_date"
    t.string "feed_path", limit: 255
    t.boolean "affiliate", default: false
    t.integer "referer_id"
    t.boolean "sign_up_email_sent", default: false
    t.boolean "send_weekly_emails", default: true
    t.integer "language_id"
    t.index ["authentication_token"], name: "index_core_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_core_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_core_users_on_email", unique: true
    t.index ["language_id"], name: "index_core_users_on_language_id"
    t.index ["name"], name: "index_core_users_on_name"
    t.index ["referer_id"], name: "index_core_users_on_referer_id"
    t.index ["reset_password_token"], name: "index_core_users_on_reset_password_token", unique: true
  end

  create_table "core_users_oust_tenders", id: :serial, force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "user_id", null: false
    t.index ["tender_id"], name: "index_core_users_oust_tenders_on_tender_id"
    t.index ["user_id"], name: "index_core_users_oust_tenders_on_user_id"
  end

  create_table "core_world_regions", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "name", limit: 255, null: false
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.string "queue", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.string "type_name", limit: 255, null: false
    t.string "type_code", limit: 255, null: false
    t.string "storage_key", limit: 255, null: false
    t.string "mime_type", limit: 255, null: false
    t.integer "content_length", null: false
    t.string "url", limit: 4096
    t.boolean "is_valid", default: true, null: false
    t.integer "notice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notice_id", "type_name", "type_code"], name: "index_documents_on_notice_id_and_type_name_and_type_code", unique: true
    t.index ["notice_id"], name: "index_documents_on_notice_id"
    t.index ["storage_key"], name: "index_documents_on_storage_key"
  end

  create_table "favourite_monitors", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "search_monitor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["search_monitor_id"], name: "index_favourite_monitors_on_search_monitor_id"
    t.index ["user_id"], name: "index_favourite_monitors_on_user_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "image"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name", default: "", null: false
  end

  create_table "industries_profiles", id: false, force: :cascade do |t|
    t.bigint "industry_id"
    t.bigint "profile_id"
    t.index ["industry_id"], name: "index_industries_profiles_on_industry_id"
    t.index ["profile_id"], name: "index_industries_profiles_on_profile_id"
  end

  create_table "industry_codes", force: :cascade do |t|
    t.string "entity_code_name", default: "", null: false
    t.integer "entity_code_id", default: 0, null: false
    t.bigint "industry_id"
    t.index ["industry_id"], name: "index_industry_codes_on_industry_id"
  end

  create_table "key_values", id: :serial, force: :cascade do |t|
    t.string "key", limit: 512, null: false
    t.text "value"
    t.index ["key"], name: "index_key_values_on_key", unique: true
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.index ["name"], name: "index_keywords_on_name"
  end

  create_table "keywords_profiles", id: false, force: :cascade do |t|
    t.bigint "keyword_id"
    t.bigint "profile_id"
    t.index ["keyword_id"], name: "index_keywords_profiles_on_keyword_id"
    t.index ["profile_id"], name: "index_keywords_profiles_on_profile_id"
  end

  create_table "marketplace_bid_no_bid_answers", force: :cascade do |t|
    t.text "answer_text"
    t.integer "position"
    t.bigint "bid_no_bid_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bid_no_bid_question_id"], name: "index_marketplace_bid_no_bid_answers_on_bid_no_bid_question_id"
  end

  create_table "marketplace_bid_no_bid_questions", force: :cascade do |t|
    t.text "question_text"
    t.integer "position"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_marketplace_bid_no_bid_questions_on_tender_id"
  end

  create_table "marketplace_compete_bid_no_bid_answers", force: :cascade do |t|
    t.text "answer_text"
    t.bigint "bid_no_bid_answer_id"
    t.text "comment"
    t.bigint "bid_no_bid_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["bid_no_bid_answer_id"], name: "index_compete_bnb_answers_on_bnb_answer"
    t.index ["bid_no_bid_question_id"], name: "index_compete_bnb_answers_on_bnb_question"
    t.index ["user_id"], name: "index_marketplace_compete_bid_no_bid_answers_on_user_id"
  end

  create_table "marketplace_tender_award_criteria", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.text "description"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_marketplace_tender_award_criteria_on_section_id"
  end

  create_table "marketplace_tender_award_criteria_sections", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_marketplace_tender_award_criteria_sections_on_tender_id"
  end

  create_table "marketplace_tender_committees", force: :cascade do |t|
    t.bigint "tender_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_marketplace_tender_committees_on_tender_id"
    t.index ["user_id"], name: "index_marketplace_tender_committees_on_user_id"
  end

  create_table "marketplace_tender_criteria", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tender_id"
    t.bigint "section_id"
    t.bigint "parent_id"
    t.text "description"
    t.index ["parent_id"], name: "index_marketplace_tender_criteria_on_parent_id"
    t.index ["section_id"], name: "index_marketplace_tender_criteria_on_section_id"
    t.index ["tender_id"], name: "index_marketplace_tender_criteria_on_tender_id"
  end

  create_table "marketplace_tender_criteria_sections", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_marketplace_tender_criteria_sections_on_tender_id"
  end

  create_table "marketplace_tender_task_sections", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_marketplace_tender_task_sections_on_tender_id"
  end

  create_table "marketplace_tender_tasks", force: :cascade do |t|
    t.integer "order"
    t.string "title"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tender_id"
    t.bigint "section_id"
    t.index ["section_id"], name: "index_marketplace_tender_tasks_on_section_id"
    t.index ["tender_id"], name: "index_marketplace_tender_tasks_on_tender_id"
  end

  create_table "notices", id: :serial, force: :cascade do |t|
    t.text "previous_id"
    t.text "title", null: false
    t.string "url", limit: 4096, null: false
    t.string "source_id", limit: 255, null: false
    t.string "source", limit: 255, null: false
    t.boolean "is_analyzed", default: false, null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_key", limit: 255, null: false
    t.boolean "disabled", default: false, null: false
    t.string "error_messages", limit: 4096
    t.index ["previous_id"], name: "index_notices_on_previous_id"
    t.index ["source"], name: "index_notices_on_source"
    t.index ["source_id"], name: "index_notices_on_source_id"
    t.index ["title"], name: "index_notices_on_title"
    t.index ["unique_key"], name: "index_notices_on_unique_key", unique: true
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
    t.string "timezone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_type", default: 0, null: false
    t.string "avatar"
    t.string "cover_img"
    t.string "city", default: "", null: false
    t.boolean "do_marketplace_available", default: false, null: false
    t.integer "company_size"
    t.integer "turnover"
    t.bigint "country_id"
    t.bigint "industry_id"
    t.integer "valueFrom", default: 0, null: false
    t.integer "valueTo", default: 0, null: false
    t.integer "tender_level", default: 0, null: false
    t.integer "number_public_contracts", default: 0, null: false
    t.string "company"
    t.index ["country_id"], name: "index_profiles_on_country_id"
    t.index ["industry_id"], name: "index_profiles_on_industry_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reduced_notices", id: :serial, force: :cascade do |t|
    t.string "title", limit: 4096, null: false
    t.string "authority_name", limit: 4096, null: false
    t.string "authority_email", limit: 255
    t.string "country_name", limit: 255, null: false
    t.string "status_name", limit: 255, null: false
    t.text "reduced_attributes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "synchronized_at"
    t.string "deleted_merge_ids", limit: 255, default: [], null: false, array: true
    t.boolean "is_synchronized", default: false, null: false
    t.datetime "submission_datetime"
    t.boolean "disabled", default: false, null: false
    t.string "error_messages", limit: 4096
    t.text "edit_diff", default: "--- {}\n", null: false
    t.string "file_reference_number", limit: 255
    t.index ["authority_email"], name: "index_reduced_notices_on_authority_email"
    t.index ["authority_name"], name: "index_reduced_notices_on_authority_name"
    t.index ["country_name"], name: "index_reduced_notices_on_country_name"
    t.index ["status_name"], name: "index_reduced_notices_on_status_name"
    t.index ["title"], name: "index_reduced_notices_on_title"
  end

  create_table "registration_requests", force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "company", default: "", null: false
    t.string "company_size", default: "0", null: false
    t.string "state", default: "", null: false
    t.string "country", default: "", null: false
    t.string "city", default: "", null: false
    t.string "turnover", default: "0", null: false
    t.json "markets", default: {}, null: false
    t.integer "tender_level", default: 0, null: false
    t.string "win_rate", default: "0.0", null: false
    t.string "number_public_contracts", default: "0", null: false
    t.boolean "do_use_automation", default: false, null: false
    t.boolean "do_use_collaboration", default: false, null: false
    t.boolean "do_use_bid_no_bid", default: false, null: false
    t.boolean "do_use_bid_library", default: false, null: false
    t.boolean "do_use_feedback", default: false, null: false
    t.boolean "do_collaborate", default: false, null: false
    t.string "tender_complete_time", default: "0.0", null: false
    t.string "organisation_count", default: "0", null: false
    t.boolean "do_processed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.bigint "industry_id"
    t.string "email", default: "", null: false
    t.string "phone"
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
    t.boolean "is_archived", default: false
    t.index ["user_id"], name: "index_search_monitors_on_user_id"
  end

  create_table "simple_captcha_data", id: :serial, force: :cascade do |t|
    t.string "key", limit: 40
    t.string "value", limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "idx_key"
  end

  create_table "suppliers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["tender_id"], name: "index_suppliers_on_tender_id"
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "tender_criteria_answers", force: :cascade do |t|
    t.boolean "pass_fail"
    t.integer "score"
    t.boolean "closed", default: false, null: false
    t.bigint "user_id"
    t.bigint "tender_criteria_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_criteria_id"], name: "index_tender_criteria_answers_on_tender_criteria_id"
    t.index ["tender_id"], name: "index_tender_criteria_answers_on_tender_id"
    t.index ["user_id"], name: "index_tender_criteria_answers_on_user_id"
  end

  create_table "tender_task_answers", force: :cascade do |t|
    t.boolean "pass_fail"
    t.integer "score"
    t.boolean "closed", default: false, null: false
    t.bigint "user_id"
    t.bigint "tender_task_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_tender_task_answers_on_tender_id"
    t.index ["tender_task_id"], name: "index_tender_task_answers_on_tender_task_id"
    t.index ["user_id"], name: "index_tender_task_answers_on_user_id"
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

  add_foreign_key "analyzed_notices", "notices", name: "analyzed_notices_notice_id_fk"
  add_foreign_key "analyzed_notices", "reduced_notices", name: "analyzed_notices_reduced_notice_id_fk", on_delete: :nullify
  add_foreign_key "assistances", "users"
  add_foreign_key "attachments_core_tenders", "attachments"
  add_foreign_key "attachments_core_tenders", "core_tenders", column: "tender_id"
  add_foreign_key "bidsense_results", "core_tenders", column: "tender_id"
  add_foreign_key "bidsense_results", "profiles"
  add_foreign_key "case_studies", "profiles"
  add_foreign_key "case_studies_galleries", "case_studies"
  add_foreign_key "case_studies_galleries", "galleries"
  add_foreign_key "case_studies_industry_codes", "case_studies"
  add_foreign_key "case_studies_industry_codes", "industry_codes"
  add_foreign_key "collaboration_interests", "core_tenders", column: "tender_id"
  add_foreign_key "collaboration_interests", "users"
  add_foreign_key "collaborators", "collaborations"
  add_foreign_key "collaborators", "users"
  add_foreign_key "compete_answers", "compete_comments"
  add_foreign_key "compete_answers", "users"
  add_foreign_key "compete_comments", "core_tenders", column: "tender_id"
  add_foreign_key "compete_comments", "users"
  add_foreign_key "contacts", "profiles"
  add_foreign_key "core_additional_information", "core_tenders", column: "tender_id", name: "core_additional_information_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_awards", "core_organizations", column: "organization_id", name: "core_awards_organization_id_fk", on_delete: :cascade
  add_foreign_key "core_awards", "core_tenders", column: "tender_id", name: "core_awards_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_bid_questions", "core_bid_question_templates", column: "template_id", name: "core_bid_questions_template_id_fk", on_delete: :cascade
  add_foreign_key "core_cities", "core_countries", column: "country_id", name: "core_cities_country_id_fk"
  add_foreign_key "core_contacts", "core_organizations", column: "organization_id", name: "core_contacts_organization_id_fk", on_delete: :cascade
  add_foreign_key "core_contacts", "core_regions", column: "region_id", name: "core_contacts_region_id_fk", on_delete: :nullify
  add_foreign_key "core_countries", "core_currencies", column: "currency_id", name: "core_countries_currency_id_fk", on_delete: :nullify
  add_foreign_key "core_countries_profiles", "core_countries", column: "country_id"
  add_foreign_key "core_countries_profiles", "profiles"
  add_foreign_key "core_documents", "core_tenders", column: "tender_id", name: "core_documents_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_lots", "core_tenders", column: "tender_id", name: "core_lots_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations", "core_countries", column: "country_id", name: "core_organizations_country_id_fk"
  add_foreign_key "core_organizations", "core_regions", column: "region_id", name: "core_organizations_region_id_fk", on_delete: :nullify
  add_foreign_key "core_organizations_cpvs", "core_cpvs", column: "cpv_id", name: "core_organizations_cpvs_cpv_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations_cpvs", "core_organizations", column: "organization_id", name: "core_organizations_cpvs_organization_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations_naicses", "core_naicses", column: "naics_id", name: "core_organizations_naicses_naics_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations_naicses", "core_organizations", column: "company_id", name: "core_organizations_naicses_company_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations_unspsces", "core_organizations", column: "company_id", name: "core_organizations_unspsces_company_id_fk", on_delete: :cascade
  add_foreign_key "core_organizations_unspsces", "core_unspsces", column: "unspsc_id", name: "core_organizations_unspsces_unspsc_id_fk", on_delete: :cascade
  add_foreign_key "core_regions", "core_countries", column: "country_id", name: "core_regions_country_id_fk", on_delete: :cascade
  add_foreign_key "core_saved_searches", "core_users", column: "user_id", name: "core_saved_searches_user_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders", "core_currencies", column: "currency_id", name: "core_tenders_currency_id_fk"
  add_foreign_key "core_tenders", "core_organizations", column: "organization_id", name: "core_tenders_organization_id_fk"
  add_foreign_key "core_tenders", "core_procedures", column: "procedure_id", name: "core_tenders_procedure_id_fk"
  add_foreign_key "core_tenders", "industries"
  add_foreign_key "core_tenders_african_codes", "core_african_codes", column: "afr_code_id", name: "core_tenders_african_codes_afr_code_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_african_codes", "core_tenders", column: "tender_id", name: "core_tenders_african_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_categories", "core_categories", column: "category_id", name: "core_tenders_categories_category_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_categories", "core_tenders", column: "tender_id", name: "core_tenders_categories_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_contacts", "core_contacts", column: "contact_id", name: "core_tenders_contacts_contact_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_contacts", "core_tenders", column: "tender_id", name: "core_tenders_contacts_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_cpvs", "core_cpvs", column: "cpv_id", name: "core_tenders_cpvs_cpv_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_cpvs", "core_tenders", column: "tender_id", name: "core_tenders_cpvs_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_gsin_codes", "core_gsin_codes", column: "gsin_id", name: "core_tenders_gsin_codes_gsin_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_gsin_codes", "core_tenders", column: "tender_id", name: "core_tenders_gsin_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_naicses", "core_naicses", column: "naics_id", name: "core_tenders_naicses_naics_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_naicses", "core_tenders", column: "tender_id", name: "core_tenders_naicses_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_ngip_codes", "core_ngip_codes", column: "ngip_code_id", name: "core_tenders_ngip_codes_ngip_code_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_ngip_codes", "core_tenders", column: "tender_id", name: "core_tenders_ngip_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nhs_e_classes", "core_nhs_e_classes", column: "nhs_eclass_id", name: "core_tenders_nhs_e_classes_nhs_eclass_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nhs_e_classes", "core_tenders", column: "tender_id", name: "core_tenders_nhs_e_classes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nigp_codes", "core_nigp_codes", column: "nigp_code_id", name: "core_tenders_nigp_codes_nigp_code_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nigp_codes", "core_tenders", column: "tender_id", name: "core_tenders_nigp_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_pro_classes", "core_pro_classes", column: "pro_class_id", name: "core_tenders_pro_classes_pro_class_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_pro_classes", "core_tenders", column: "tender_id", name: "core_tenders_pro_classes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_sfgov_codes", "core_sfgov_codes", column: "sfgov_id", name: "core_tenders_sfgov_codes_sfgov_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_sfgov_codes", "core_tenders", column: "tender_id", name: "core_tenders_sfgov_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_unspsces", "core_tenders", column: "tender_id", name: "core_tenders_unspsces_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_unspsces", "core_unspsces", column: "unspsc_id", name: "core_tenders_unspsces_unspsc_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_users", "core_tenders", column: "tender_id"
  add_foreign_key "core_tenders_users", "users"
  add_foreign_key "documents", "notices", name: "documents_notice_id_fk"
  add_foreign_key "favourite_monitors", "search_monitors"
  add_foreign_key "favourite_monitors", "users"
  add_foreign_key "industries_profiles", "industries"
  add_foreign_key "industries_profiles", "profiles"
  add_foreign_key "industry_codes", "industries"
  add_foreign_key "keywords_profiles", "keywords"
  add_foreign_key "keywords_profiles", "profiles"
  add_foreign_key "marketplace_bid_no_bid_answers", "marketplace_bid_no_bid_questions", column: "bid_no_bid_question_id"
  add_foreign_key "marketplace_bid_no_bid_questions", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_compete_bid_no_bid_answers", "marketplace_bid_no_bid_answers", column: "bid_no_bid_answer_id", name: "index_compete_bnb_answers_on_bnb_answer"
  add_foreign_key "marketplace_compete_bid_no_bid_answers", "marketplace_bid_no_bid_questions", column: "bid_no_bid_question_id", name: "index_compete_bnb_answers_on_bnb_question"
  add_foreign_key "marketplace_compete_bid_no_bid_answers", "users"
  add_foreign_key "marketplace_tender_award_criteria", "marketplace_tender_award_criteria_sections", column: "section_id"
  add_foreign_key "marketplace_tender_award_criteria_sections", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_committees", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_criteria", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_criteria", "marketplace_tender_criteria_sections", column: "section_id"
  add_foreign_key "marketplace_tender_criteria_sections", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_task_sections", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_tasks", "core_tenders", column: "tender_id"
  add_foreign_key "marketplace_tender_tasks", "marketplace_tender_task_sections", column: "section_id"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "profiles", "core_countries", column: "country_id"
  add_foreign_key "profiles", "industries"
  add_foreign_key "profiles", "users"
  add_foreign_key "registration_requests", "core_countries", column: "country_id"
  add_foreign_key "registration_requests", "industries"
  add_foreign_key "search_monitors", "users"
  add_foreign_key "suppliers", "core_tenders", column: "tender_id"
  add_foreign_key "suppliers", "users"
  add_foreign_key "tender_criteria_answers", "core_tenders", column: "tender_id"
  add_foreign_key "tender_criteria_answers", "marketplace_tender_criteria", column: "tender_criteria_id"
  add_foreign_key "tender_criteria_answers", "users"
  add_foreign_key "tender_task_answers", "core_tenders", column: "tender_id"
  add_foreign_key "tender_task_answers", "marketplace_tender_tasks", column: "tender_task_id"
  add_foreign_key "tender_task_answers", "users"
end
