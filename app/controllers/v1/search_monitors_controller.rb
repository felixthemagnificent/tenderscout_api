class V1::SearchMonitorsController < ApplicationController
  before_action :set_search_monitor, only: [:show, :update, :destroy, :result, :archive, :share,
                                            :add_favourite, :delete_favourite, :export]
  after_action :verify_authorized, except: [:delete_favourite, :add_favourite]
  respond_to :json
  # GET /search_monitors
  def index
    @search_monitors = current_user.search_monitors
    authorize @search_monitors
    render json: @search_monitors
  end

  # GET /search_monitors/1
  def show
    authorize @search_monitor
    render json: @search_monitor
  end

  def preview
    authorize SearchMonitor
    data, count = preview_search(search_monitor_params)
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def all_results
    authorize SearchMonitor
    data, count = process_search({})
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end

  def share
    render json: nil
  end

  def archive
    authorize SearchMonitor
    if @search_monitor.update(is_archived: true)
      render json: nil, status: :ok
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  def delete_favourite
    current_user.favourite_monitors.where(search_monitor: @search_monitor).delete_all
    
    render json: @search_monitor, status: :ok
  end

  def add_favourite
    current_user.favourite_monitors.find_or_create_by search_monitor: @search_monitor
    
    render json: @search_monitor, status: :ok
  end

  def result
    authorize SearchMonitor
    results = @search_monitor.results
    data, count = serialize_core_tenders_search(results)
    render json: {
      data: data,
      count: count
    }, current_user: current_user
  end



  # POST /search_monitors
  def create
    @search_monitor = current_user.search_monitors.new(search_monitor_params)
    authorize @search_monitor
    if @search_monitor.save
      render json: @search_monitor, status: :created
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /search_monitors/1
  def update
    authorize @search_monitor
    if @search_monitor.update(search_monitor_params)
      render json: @search_monitor
    else
      render json: @search_monitor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /search_monitors/1
  def destroy
    authorize @search_monitor
    @search_monitor.destroy
  end

  def export
    authorize SearchMonitor
    SearchMonitor::MonitorExport.perform_later @search_monitor
  end


  private
    def serialize_core_tenders_search(results)
      tenders = results.page(params[:page]).per(params[:page_size]).objects.map do |tender|
        # options = {serializer: TenderSerializer, scope: {current_user: current_user, search_monitor: @search_monitor} }
        # ActiveModelSerializers::SerializableResource.new(tender, options).serializer.attributes
        TenderSerializer.new(tender, current_user: current_user, search_monitor: @search_monitor).attributes
      end
      return tenders, results.count
    end

    def preview_search(search_monitor_params)
      tender_title = search_monitor_params[:tenderTitle]
      tender_keywords = search_monitor_params[:keywordList]
      tender_value_from = search_monitor_params[:valueFrom]
      tender_value_to = search_monitor_params[:valueTo]
      tender_countries = search_monitor_params[:countryList]
      tender_buyers = search_monitor_params[:buyer]
    
      cur_page = params[:page]
      page_size = params[:page_size]
    
      results = Core::Tender.search(
        tender_title: tender_title,
        tender_keywords: tender_keywords,
        tender_value_from: tender_value_from,
        tender_value_to: tender_value_to,
        tender_countries: tender_countries,
        tender_buyers: tender_buyers
        )
      tenders = results.page(cur_page).per(page_size).objects.map do |tender|
        # options = {serializer: TenderSerializer, scope: {current_user: current_user, search_monitor: @search_monitor} }
        # ActiveModelSerializers::SerializableResource.new(tender, options).serializer.attributes
        TenderSerializer.new(tender, current_user: current_user, search_monitor: @search_monitor).attributes
      end
      return tenders, results.count
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_search_monitor
      @search_monitor = SearchMonitor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def search_monitor_params
      params.permit(:title, :tenderTitle, :valueFrom, :valueTo, :buyer, codeList:[], countryList:[], statusList:[], keywordList:[])
    end
end
