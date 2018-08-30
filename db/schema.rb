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

ActiveRecord::Schema.define(version: 20180831151350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "african_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_african_codes_on_code"
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

  create_table "core_additional_information", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "url", limit: 4096, null: false
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tender_id"], name: "index_core_additional_information_on_tender_id"
    t.index ["title"], name: "index_core_additional_information_on_title"
  end

  create_table "core_awards", force: :cascade do |t|
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

  create_table "core_categories", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_categories_on_code"
  end

  create_table "core_cities", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "index_core_cities_on_country_id"
    t.index ["name"], name: "index_core_cities_on_name"
  end

  create_table "core_classification_codes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_classification_codes_on_code"
  end

  create_table "core_comments", force: :cascade do |t|
    t.text "commentary", null: false
    t.integer "creator_id", null: false
    t.integer "analyzed_tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "core_contacts", force: :cascade do |t|
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
    t.index ["organization_id"], name: "index_core_contacts_on_organization_id"
    t.index ["region_id"], name: "index_core_contacts_on_region_id"
  end

  create_table "core_countries", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "number", limit: 255, null: false
    t.string "alpha2code", limit: 255, null: false
    t.string "alpha3code", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "world_region", limit: 255, null: false
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

  create_table "core_cpvs", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_cpvs_on_code"
  end

  create_table "core_currencies", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "code", limit: 255, null: false
    t.string "unit", limit: 255
    t.index ["code"], name: "index_core_currencies_on_code", unique: true
    t.index ["name"], name: "index_core_currencies_on_name"
  end

  create_table "core_documents", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "url", limit: 4096, null: false
    t.integer "tender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tender_id"], name: "index_core_documents_on_tender_id"
    t.index ["title"], name: "index_core_documents_on_title"
  end

  create_table "core_gsin_codes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_gsin_codes_on_code"
  end

  create_table "core_naicses", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_naicses_on_code"
  end

  create_table "core_ngip_codes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_ngip_codes_on_code"
  end

  create_table "core_nhs_e_classes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 300, null: false
    t.index ["code"], name: "index_core_nhs_e_classes_on_code"
  end

  create_table "core_nigp_codes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_nigp_codes_on_code"
  end

  create_table "core_organizations", force: :cascade do |t|
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
    t.index ["country_id"], name: "index_core_organizations_on_country_id"
    t.index ["name", "country_id", "creator_id"], name: "index_core_organizations_on_name_and_country_id_and_creator_id", unique: true
    t.index ["name"], name: "index_core_organizations_on_name"
    t.index ["region_id"], name: "index_core_organizations_on_region_id"
  end

  create_table "core_pro_classes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 300, null: false
    t.index ["code"], name: "index_core_pro_classes_on_code"
  end

  create_table "core_procedures", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.index ["name"], name: "index_core_procedures_on_name", unique: true
  end

  create_table "core_sfgov_codes", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_sfgov_codes_on_code"
  end

  create_table "core_tenders", force: :cascade do |t|
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
    t.integer "spider_id"
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
    t.index ["industry_id"], name: "index_core_tenders_on_industry_id"
    t.index ["organization_id"], name: "index_core_tenders_on_organization_id"
    t.index ["procedure_id"], name: "index_core_tenders_on_procedure_id"
    t.index ["spider_id"], name: "index_core_tenders_on_spider_id", unique: true
    t.index ["title"], name: "index_core_tenders_on_title"
  end

  create_table "core_tenders_categories", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id", "tender_id"], name: "index_core_tenders_categories_on_category_id_and_tender_id", unique: true
    t.index ["category_id"], name: "index_core_tenders_categories_on_category_id"
    t.index ["tender_id", "category_id"], name: "index_core_tenders_categories_on_tender_id_and_category_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_categories_on_tender_id"
  end

  create_table "core_tenders_contacts", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "contact_id", null: false
    t.index ["contact_id", "tender_id"], name: "index_core_tenders_contacts_on_contact_id_and_tender_id", unique: true
    t.index ["contact_id"], name: "index_core_tenders_contacts_on_contact_id"
    t.index ["tender_id", "contact_id"], name: "index_core_tenders_contacts_on_tender_id_and_contact_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_contacts_on_tender_id"
  end

  create_table "core_tenders_cpvs", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "cpv_id", null: false
    t.index ["cpv_id", "tender_id"], name: "index_core_tenders_cpvs_on_cpv_id_and_tender_id", unique: true
    t.index ["cpv_id"], name: "index_core_tenders_cpvs_on_cpv_id"
    t.index ["tender_id", "cpv_id"], name: "index_core_tenders_cpvs_on_tender_id_and_cpv_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_cpvs_on_tender_id"
  end

  create_table "core_tenders_gsin_codes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "gsin_id", null: false
    t.index ["gsin_id", "tender_id"], name: "index_core_tenders_gsin_codes_on_gsin_id_and_tender_id", unique: true
    t.index ["gsin_id"], name: "index_core_tenders_gsin_codes_on_gsin_id"
    t.index ["tender_id", "gsin_id"], name: "index_core_tenders_gsin_codes_on_tender_id_and_gsin_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_gsin_codes_on_tender_id"
  end

  create_table "core_tenders_naicses", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "naics_id", null: false
    t.index ["naics_id", "tender_id"], name: "index_core_tenders_naicses_on_naics_id_and_tender_id", unique: true
    t.index ["naics_id"], name: "index_core_tenders_naicses_on_naics_id"
    t.index ["tender_id", "naics_id"], name: "index_core_tenders_naicses_on_tender_id_and_naics_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_naicses_on_tender_id"
  end

  create_table "core_tenders_ngip_codes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "ngip_code_id", null: false
    t.index ["ngip_code_id", "tender_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id_and_tender_id", unique: true
    t.index ["ngip_code_id"], name: "index_core_tenders_ngip_codes_on_ngip_code_id"
    t.index ["tender_id", "ngip_code_id"], name: "index_core_tenders_ngip_codes_on_tender_id_and_ngip_code_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_ngip_codes_on_tender_id"
  end

  create_table "core_tenders_nhs_e_classes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "nhs_eclass_id", null: false
    t.index ["nhs_eclass_id", "tender_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id_and_tender_id", unique: true
    t.index ["nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_nhs_eclass_id"
    t.index ["tender_id", "nhs_eclass_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id_and_nhs_eclass_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_nhs_e_classes_on_tender_id"
  end

  create_table "core_tenders_nigp_codes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "nigp_code_id", null: false
    t.index ["nigp_code_id", "tender_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id_and_tender_id", unique: true
    t.index ["nigp_code_id"], name: "index_core_tenders_nigp_codes_on_nigp_code_id"
    t.index ["tender_id", "nigp_code_id"], name: "index_core_tenders_nigp_codes_on_tender_id_and_nigp_code_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_nigp_codes_on_tender_id"
  end

  create_table "core_tenders_pro_classes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "pro_class_id", null: false
    t.index ["pro_class_id", "tender_id"], name: "index_core_tenders_pro_classes_on_pro_class_id_and_tender_id", unique: true
    t.index ["pro_class_id"], name: "index_core_tenders_pro_classes_on_pro_class_id"
    t.index ["tender_id", "pro_class_id"], name: "index_core_tenders_pro_classes_on_tender_id_and_pro_class_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_pro_classes_on_tender_id"
  end

  create_table "core_tenders_sfgov_codes", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "sfgov_id", null: false
    t.index ["sfgov_id", "tender_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id_and_tender_id", unique: true
    t.index ["sfgov_id"], name: "index_core_tenders_sfgov_codes_on_sfgov_id"
    t.index ["tender_id", "sfgov_id"], name: "index_core_tenders_sfgov_codes_on_tender_id_and_sfgov_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_sfgov_codes_on_tender_id"
  end

  create_table "core_tenders_unspsces", force: :cascade do |t|
    t.integer "tender_id", null: false
    t.integer "unspsc_id", null: false
    t.index ["tender_id", "unspsc_id"], name: "index_core_tenders_unspsces_on_tender_id_and_unspsc_id", unique: true
    t.index ["tender_id"], name: "index_core_tenders_unspsces_on_tender_id"
    t.index ["unspsc_id", "tender_id"], name: "index_core_tenders_unspsces_on_unspsc_id_and_tender_id", unique: true
    t.index ["unspsc_id"], name: "index_core_tenders_unspsces_on_unspsc_id"
  end

  create_table "core_unspsces", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "description", limit: 255, null: false
    t.index ["code"], name: "index_core_unspsces_on_code"
  end

  create_table "core_user_countries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "country_id", null: false
    t.integer "number_of_occurrences", default: 0
  end

  create_table "core_world_regions", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.string "name", limit: 255, null: false
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

  create_table "gsin_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_gsin_codes_on_code"
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
    t.float "win_rate", default: 0.0, null: false
    t.string "number_public_contracts", default: "0", null: false
    t.boolean "do_use_automation", default: false, null: false
    t.boolean "do_use_collaboration", default: false, null: false
    t.boolean "do_use_bid_no_bid", default: false, null: false
    t.boolean "do_use_bid_library", default: false, null: false
    t.boolean "do_use_feedback", default: false, null: false
    t.boolean "do_collaborate", default: false, null: false
    t.string "tender_complete_time", default: "0.0", null: false
    t.integer "organisation_count", default: 0, null: false
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

  create_table "sfgov_codes", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
    t.index ["code"], name: "index_sfgov_codes_on_code"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "status", default: "pending", null: false
    t.bigint "user_id"
    t.bigint "tender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_suppliers_on_tender_id"
    t.index ["user_id"], name: "index_suppliers_on_user_id"
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

  add_foreign_key "attachments_core_tenders", "attachments"
  add_foreign_key "attachments_core_tenders", "core_tenders", column: "tender_id"
  add_foreign_key "case_studies", "profiles"
  add_foreign_key "case_studies_galleries", "case_studies"
  add_foreign_key "case_studies_galleries", "galleries"
  add_foreign_key "case_studies_industry_codes", "case_studies"
  add_foreign_key "case_studies_industry_codes", "industry_codes"
  add_foreign_key "contacts", "profiles"
  add_foreign_key "core_countries_profiles", "core_countries", column: "country_id"
  add_foreign_key "core_countries_profiles", "profiles"
  add_foreign_key "core_tenders", "industries"
  add_foreign_key "core_tenders_categories", "core_categories", column: "category_id", name: "core_tenders_categories_category_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_categories", "core_tenders", column: "tender_id", name: "core_tenders_categories_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_ngip_codes", "core_ngip_codes", column: "ngip_code_id", name: "core_tenders_ngip_codes_ngip_code_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_ngip_codes", "core_tenders", column: "tender_id", name: "core_tenders_ngip_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nigp_codes", "core_nigp_codes", column: "nigp_code_id", name: "core_tenders_nigp_codes_nigp_code_id_fk", on_delete: :cascade
  add_foreign_key "core_tenders_nigp_codes", "core_tenders", column: "tender_id", name: "core_tenders_nigp_codes_tender_id_fk", on_delete: :cascade
  add_foreign_key "countries", "currencies", column: "currencies_id"
  add_foreign_key "countries", "world_regions", column: "world_regions_id"
  add_foreign_key "favourite_monitors", "search_monitors"
  add_foreign_key "favourite_monitors", "users"
  add_foreign_key "industries_profiles", "industries"
  add_foreign_key "industries_profiles", "profiles"
  add_foreign_key "industry_codes", "industries"
  add_foreign_key "keywords_profiles", "keywords"
  add_foreign_key "keywords_profiles", "profiles"
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
  add_foreign_key "registration_requests", "countries"
  add_foreign_key "registration_requests", "industries"
  add_foreign_key "search_monitors", "users"
  add_foreign_key "suppliers", "core_tenders", column: "tender_id"
  add_foreign_key "suppliers", "users"
end
