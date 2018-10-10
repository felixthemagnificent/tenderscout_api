class V1::Marketplace::AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:update, :destroy]

  def create
    if ::Marketplace::Assignment::ASSIGNMENT_MODEL.key?(params[:assignable_type])
      assignments_model = ::Marketplace::Assignment::ASSIGNMENT_MODEL[params[:assignable_type]]
    else
      render json: {error: 'Unvalid assignable type'}
      return false
    end
    @assignment = Marketplace::Assignment.new(assignments_params)
    @assignment.assignable_type = assignments_model
    if @assignment.save
      render json: @assignment, status: :created
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @assignment.update(assignments_params)
      render json: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @assignment.destroy
  end

  private
  def set_assignment
    @assignment = ::Marketplace::Assignment.find(params[:id])
  end

  def assignments_params
    params.permit(:assignable_type, :assignable_id, :user_id, :collaboration_id)
  end
end