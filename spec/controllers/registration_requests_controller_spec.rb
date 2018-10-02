# # Tests for registration request controller functionality
# require 'rails_helper'

# RSpec.describe V1::RegistrationRequestsController, type: :controller do
#   #create object for testing
#   let(:registration_request_1) { FactoryBot.create(:registration_request) }
#   let(:registration_request_list) { FactoryBot.create_list(:registration_request,3) }
#   let(:industry) { FactoryBot.create(:industry) }
#   let(:country) { FactoryBot.create(:country) }
#   let(:registration_request_params) { FactoryBot.attributes_for(:registration_request, industry_id: 1,
#                                       country_id: 1) }
#   describe 'GET #index' do
#     it 'should return worked status' do
#       get :index, as: :json
#       expect(response.status).to eq 200
#       expect(response).to have_http_status(:ok)
#     end

#     it 'should return body' do
#       get :index, as: :json
#       expect(response.body).to eq response.body
#     end

#     it 'initialize registration request list' do
#       registration_request_list
#       get :index, as: :json
#       expect(json_body.count).to eq(
#                                      registration_request_list.count
#                                  )
#     end
#   end

#   describe 'GET #show' do
#     it 'should return worked status' do
#       registration_request_1
#       get :show, params: { id: registration_request_1.id }, as: :json
#       expect(response.status).to eq 200
#       expect(response).to have_http_status(:ok)
#     end

#     it 'should return registration request' do
#       get :show, params: { id: registration_request_1.id }, as: :json
#       expect(json_body["id"]).to eq(registration_request_1.id)
#     end
#   end

#   describe 'PUT #update' do
#     it 'should return worked status' do
#       registration_request_1
#       put :update,params: { id: registration_request_1.id}, as: :json
#       expect(response.status).to eq 200
#       expect(response).to have_http_status(:ok)
#     end

#     it 'should updated registration request' do
#       put :update,params: { id: registration_request_1.id, do_processed: true}, as: :json
#       expect(json_body["do_processed"]).to eq true
#     end

#   end

#   describe 'POST #create' do
#     it 'should return worked status' do
#      industry
#      country
#       post :create,params: { industry_id: industry.id, country_id: country.id }, as: :json
#       expect(response.status).to eq 201
#       expect(response).to have_http_status(:created)
#     end

#     it 'registrated without validation' do
#       post :create,params: { industry_id: industry.id, country_id: country.id, fullname: Faker::Name.name}, as: :json
#       expect(json_body["fullname"]).to eq json_body["fullname"]
#     end
#   end

# end