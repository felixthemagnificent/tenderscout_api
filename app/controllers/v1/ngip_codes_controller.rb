class V1::NgipCodesController < ApplicationController
  before_action :set_code, only: [:show, :update]

  def index
    render json: NgipCode.all

  end

  def create
    @code = NgipCode.new(code_params)

    if @code.save
      render json: @code, status: :created
    else
      render json: @code.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @code
  end

  def update
    if @code.update(code_params)
      render json: nil, status: :ok
    else
      render json: @code.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_code
    @code = NgipCode.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def code_params
    params.permit(:code, :description)
  end

end
