class V1::SearchMonitorsController < ApplicationController
  before_action :set_search_monitor, only: [:show, :update, :destroy]

  # GET /search_monitors
  def index
    @search_monitors = current_user.search_monitors

    render json: @search_monitors
  end

  # GET /search_monitors/1
  def show
    render json: @search_monitor
  end

  # POST /search_monitors
  def create
    @search_monitor = current_user.search_monitors.new(search_monitor_params)

    if @search_monitor.save
      render json: @search_monitor, status: :created
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /search_monitors/1
  def update
    if @search_monitor.update(search_monitor_params)
      render json: @search_monitor
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /search_monitors/1
  def destroy
    @search_monitor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_monitor
      @search_monitor = SearchMonitor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def search_monitor_params
      params.permit(:title, :tenderTitle, :countryList, :keywordList, :valueFrom, :valueTo, :codeList, :buyerList, :statusList)
    end
end
