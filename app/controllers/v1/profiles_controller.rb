class V1::ProfilesController < ApplicationController
  include ActionController::Serialization
  before_action :set_profile, only: [:show, :update, :destroy]
  before_action :set_industry, except: [:index, :destroy]
  before_action :set_country, except: [:index, :destroy]
  before_action :set_user

  # GET /profiles
  def index
    @profiles = @user.profiles
    render json: @profiles
  end

  # GET /profiles/1
  def show
    render json: @profile
  end

  # POST /profiles
  def create
    result = CreateProfile.call(params: profile_params, user: current_user)
    if result.success?
      render json: result.profile, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    result = UpdateProfile.call(profile: @profile, params: profile_params, user: current_user)
    if result.success?
      render json: result.profile
    else
      render json: result.errors, status: result.code
    end
  end

  # DELETE /profiles/1
  def destroy
    # @profile.destroy
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

  def set_user
    @user = User.find(params[:user_id]) rescue current_user
  end
  
  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.permit(
      :fullname, :display_name, :profile_type, :city, :timezone,
      :avatar_url, :cover_img_url, :do_marketplace_available, :company_size,
      :turnover, :industry_id, :country_id, :contacts, :valueFrom, :valueTo,
      :tender_level, :number_public_contracts, keywords: [], countries: [],
      industries: []
    )
  end
end
