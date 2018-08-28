require 'test_helper'

class Marketplace::TenderTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_tender_task = marketplace_tender_tasks(:one)
  end

  test "should get index" do
    get marketplace_tender_tasks_url, as: :json
    assert_response :success
  end

  test "should create marketplace_tender_task" do
    assert_difference('Marketplace::TenderTask.count') do
      post marketplace_tender_tasks_url, params: { marketplace_tender_task: { order: @marketplace_tender_task.order, title: @marketplace_tender_task.title, weight: @marketplace_tender_task.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show marketplace_tender_task" do
    get marketplace_tender_task_url(@marketplace_tender_task), as: :json
    assert_response :success
  end

  test "should update marketplace_tender_task" do
    patch marketplace_tender_task_url(@marketplace_tender_task), params: { marketplace_tender_task: { order: @marketplace_tender_task.order, title: @marketplace_tender_task.title, weight: @marketplace_tender_task.weight } }, as: :json
    assert_response 200
  end

  test "should destroy marketplace_tender_task" do
    assert_difference('Marketplace::TenderTask.count', -1) do
      delete marketplace_tender_task_url(@marketplace_tender_task), as: :json
    end

    assert_response 204
  end
end
