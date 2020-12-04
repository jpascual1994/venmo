require 'rails_helper'

describe 'GET /api/v1/users/:id', type: :request do
  subject { get api_v1_user_path(user_id) }

  before { subject }

  context 'when user exists' do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'returns the user info' do
      expect(response.parsed_body).to include_json(
        user: {
          id: user.id,
          email: user.email,
          name: user.name
        }
      )
    end
  end

  context 'when user does not exists' do
    let(:user_id) { Faker::Number.number }

    it 'return record not found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
