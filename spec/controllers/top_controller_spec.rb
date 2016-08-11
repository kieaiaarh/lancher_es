require 'rails_helper'

RSpec.describe TopController, type: :controller, elasticsearch: true do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
