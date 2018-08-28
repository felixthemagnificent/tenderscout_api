class V1::Marketplace::TendersController < ApplicationController
  include ActionController::Serialization
  before_action :set_tender, only: [:show, :update, :destroy, :set_avatar, :destroy_avatar]

  # GET /profiles
  def index
    @tenders = Tender.all
    render json: @tenders
  end

  # GET /profiles/1
  def show
    render json: @tender
  end

  # POST /profiles
  def create
    result = CreateProfile.call(params: tender_params, user: current_user)
    if result.success?
      render json: result.tender, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    result = UpdateProfile.call(profile: @tender, params: tender_params, user: current_user)
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

  def create_avatar
    @profile.remove_avatar!
    @profile.save

    if @profie.update(avatar_params)
      render json: @profile
    else
      render json: @profile.errors, status: result.code
    end
  end

  def destroy_avatar
    @profile.remove_avatar!
    @profile.save
  end

  def create_cover_img
    @profile.remove_cover_img!
    @profile.save

    if @profie.update(cover_img_params)
      render json: @profile
    else
      render json: @profile.errors, status: result.code
    end
  end

  def destroy_cover_img
    @profile.remove_cover_img!
    @profile.save
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @profile = Profile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tender_params
    params.permit(
      :fullname, :display_name, :profile_type, :city, :timezone,
      :do_marketplace_available, :company_size, :turnover, :cover_img,
      :industry_id, :country_id, :contacts, :valueFrom, :valueTo,
      :tender_level, :number_public_contracts, keywords: [], countries: [],
      industries: []
    )
  end
end
