class V1::ProfilesController < ApplicationController
  include ActionController::Serialization
  before_action :set_profile, only: [:show, :update, :destroy]
  before_action :set_industry, except: [:index, :destroy]
  before_action :set_country, except: [:index, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all

    render json: @profiles
  end

  # GET /profiles/1
  def show
    render json: @profile
  end

  # POST /profiles
  def create
    @profile = current_user.profiles.new(profile_params)
    if @profile.save
      if contact_params
        @profile.contacts.destroy_all
        contact_params.each { |e| @profile.contacts.create(contact_type: e[:type], value: e[:value])}
      end
      render json: @profile, status: :created#, location: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      if contact_params
        @profile.contacts.destroy_all
        contact_params.each { |e| @profile.contacts.create(contact_type: e[:type], value: e[:value])}
      end
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_industry
    @industry = Industry.find(params[:industry_id])
  end

  def set_country
    @country = Core::Country.find(params[:country_id])
  end

  def contact_params
    params[:contacts]
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.permit(
      :fullname, :display_name, :profile_type, :city, :timezone,
      :avatar_url, :cover_img_url, :do_marketplace_available, :company_size,
      :turnover, :industry_id, :country_id, :contacts
    )
  end
end
