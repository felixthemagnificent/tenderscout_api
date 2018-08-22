class V1::SearchMonitorsController < ApplicationController
  before_action :set_search_monitor, only: [:show, :update, :destroy, :result, :archive, :share, :add_favourite, :delete_favourite]

  # GET /search_monitors
  def index
    @search_monitors = current_user.search_monitors

    render json: @search_monitors
  end

  # GET /search_monitors/1
  def show
    render json: @search_monitor
  end

  def preview
    data, count = process_search(search_monitor_params)
    render json: {
      data: data,
      count: count
    }
  end

  def share
    render json: nil
  end

  def archive
    if @search_monitor.update(is_archived: true)
      render json: nil, status: :ok
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  def delete_favourite
    api_current_user.favourite_monitors.where(search_monitor: @search_monitor).delete_all
    
    render json: nil, status: ok
  end

  def add_favourite
    api_current_user.favourite_monitors.find_or_create_by search_monitor: @search_monitor
    
    render json: nil, status: :ok
  end

  def result
    search_params = @search_monitor.as_json({except: [:created_at, :updated_at, :id, :user_id]}).symbolize_keys
    data, count = process_search(search_params)
    render json: {
      data: data,
      count: count
    }
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
    def process_search(search_monitor_params)
      tender_title = search_monitor_params[:tenderTitle]
      tender_keywords = search_monitor_params[:keywordList]
      tender_value_from = search_monitor_params[:valueFrom]
      tender_value_to = search_monitor_params[:valueTo]

      cur_page = params[:page]
      page_size = params[:page_size]

      results = Core::Tender.search(tender_title: tender_title, tender_keywords: tender_keywords, tender_value_from: tender_value_from, tender_value_to: tender_value_to)
      
      return results.page(cur_page).per(page_size).objects, results.count
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_search_monitor
      @search_monitor = SearchMonitor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def search_monitor_params
      params.permit(:title, :tenderTitle, :countryList, :keywordList, :valueFrom, :valueTo, :codeList, :buyerList, :statusList)
    end
end
