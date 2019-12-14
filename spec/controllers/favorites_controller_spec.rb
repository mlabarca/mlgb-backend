require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  describe 'GET #create' do
    context 'when given valid params' do
      let(:params) { attributes_for(:favorite) }

      it 'returns http success and favorite data' do
        post :create, params: params
        expect(response).to have_http_status(:success)
        resp_json = JSON.parse(response.body)
        expect(resp_json['id']).to eq Favorite.last.id
      end
    end

    context 'when given invalid params' do
      context 'because a param is missing' do
        let(:params) { {} }

        it 'returns http unprocessable entity' do
        end
      end

      context 'because there is already a faovite for that user and job id' do
        let(:favorite) { create(:favorite) }
        let(:params) { { email: favorite.email, job_id: favorite.job_id }}

        it 'returns http unprocessable entity' do
        end
      end

      after :each do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe 'GET #delete' do
    context 'when a favorite exists for that job id and email' do
      let(:favorite) { create(:favorite) }
      let(:params) { { email: favorite.email, job_id: favorite.job_id }}

      it 'returns http success' do
        delete :delete, params: params
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the favorite does not exist' do
      let(:params) { attributes_for(:favorite) }

      it 'returns http not found' do
        delete :delete, params: params
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
