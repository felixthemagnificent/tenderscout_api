# Tests for search monitors controller functionality
require 'rails_helper'

RSpec.describe V1::SearchMonitorsController, type: :controller do

  let(:search_monitors) { FactoryBot.build_list(:search_monitor, 3) }
  #let(:search_monitor_1) { FactoryBot.create(:search_monitor) }
  let(:search_monitor) { FactoryBot.build_list(:search_monitor, 1) }
  let(:favourite_monitor) { FactoryBot.create(:favourite_monitor, search_monitor: search_monitor.first) }
  let(:user) { FactoryBot.create(:user, search_monitors: search_monitor) }
  #let(:user_with_monitors) { FactoryBot.create(:user, search_monitors: search_monitors) }
  let(:tender) { FactoryBot.create{:tender} }

  describe 'GET #index' do
    login_user
    it 'should return worked status' do
      get :index, as: :json
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end

    it 'should return user monitor'  do
      get :index, as: :json
      expect(json_body[0]["title"]).to eq user.search_monitors.first.title
    end

    it 'should return user' do
      user
      get :index, as: :json
      allow_any_instance_of(V1::SearchMonitorsController).to receive(:current_user) { user }
    end

  end

  describe 'GET #show' do
    login_user
    it 'should return worked status' do
      get :show,params: {id: user.search_monitors.first.id }, as: :json
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end

    it 'should return user monitor'  do
      get :show,params: {id: user.search_monitors.first.id }, as: :json
      expect(json_body["id"]).to eq user.search_monitors.first.id
    end
  end

  describe 'DELETE #delete_favourite ' do
    login_user
    it 'should return worked status' do
      delete :delete_favourite, params: { id: favourite_monitor.search_monitor_id } ,as: :json
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end

    it 'should return record to deleting' do
      delete :delete_favourite, params: { id: favourite_monitor.search_monitor_id } ,as: :json
      expect(json_body["id"]).to eq favourite_monitor.search_monitor_id
    end

  end

  describe 'PUT #add_favourite' do
    login_user
    it 'should return worked status' do
      put :add_favourite, params: { id: favourite_monitor.search_monitor_id } ,as: :json
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end

    it 'should return record to deleting' do
      put :add_favourite, params: { id: favourite_monitor.search_monitor_id } ,as: :json
      expect(json_body["id"]).to eq favourite_monitor.search_monitor_id
    end

  end

  describe 'POST #share' do
    login_user
    it 'should return worked status' do
      post :share, params: { id: user.search_monitors.first.id } ,as: :json
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end

  end

  describe 'POST #create' do
    login_user
    it "should return worked status" do
      post :create,as: :json
      expect(response.status).to eq 201
      expect(response).to have_http_status(:created)
      expect(response.status).not_to eq 200
    end

  end

  describe 'POST #create' do
    login_user
    it "should return worked status" do
      put :update, params: { id: user.search_monitors.first.id, tenderTitle: Faker::Name.name } ,as: :json
      expect(json_body["tenderTitle"]).to eq json_body["tenderTitle"]
    end

  end

  describe 'POST #preview' do
    login_user
    it "should return worked status" do
     # tender

    end

  end


end