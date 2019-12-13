require 'rails_helper'

RSpec.describe JobsController, type: :controller do

  describe 'GET #search' do
    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end

    it 'returns a filtered json array' do
      get :search
      response_json = JSON.parse(response.body)
      expect(response_json['jobs']).to eq []
    end
  end

end
