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

  # POST /users
  def create
    @user = User.new(user_params)
    @user.profiles.new(profile_params)

    if @user.save && @user.profiles.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors.merge(@user.profiles.errors), status: :unprocessable_entity
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
end
