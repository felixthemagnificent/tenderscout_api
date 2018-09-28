class V1::UsersController < ApplicationController
  include ActionController::Serialization
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index

    users = User.all
    @users = users.my_paginate(paginate_params)

    render json: {count: users.count, data: @users}
  end

  # GET /users/1
  def show
    render json: @user
  end

  def search
    search_field = params[:query]
    results = User.search(search_field)
    count = results.count
    results = results.objects.page(paginate_params[:page]).per(paginate_params[:page_size])
    render json: {data: results, count: count}
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      profile = @user.profiles.create(profile_params)
      if 
        render json: @user, status: :created
      else
        render json: @user.profile.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def update_password
    result = UpdateProfilePassword.call(params: password_params, user: current_user)
    if result.success?
      render status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.permit(:fullname, :display_name, :timezone)
  end

  def user_params
    params.permit(:email, :password)
  end

  def password_params
    params.permit(:password, :password_confirmation, :current_password)
  end
end
