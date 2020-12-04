require 'rails_helper'

describe 'POST /api/v1/users', type: :request do
  subject { post api_v1_users_path, params: user_params }

  context 'when params are correct' do
    let(:user_params) { { user: attributes_for(:user) } }
    let(:created_user) { User.last }

    it 'returns successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates a new user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'return user info' do
      subject
      expect(response.parsed_body).to include_json(
        user: {
          id: created_user.id,
          email: created_user.email,
          name: created_user.name
        }
      )
    end
  end

  context 'when params are not valid' do
    context 'when name is missing' do
      let(:user_params) { { user: attributes_for(:user, name: nil) } }

      it 'returns bad request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create a new user' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'when email is missing' do
      let(:user_params) { { user: attributes_for(:user, email: nil) } }

      it 'returns bad request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create a new user' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'when email is already used' do
      let(:email) { Faker::Internet.email }
      let!(:previous_user) { create(:user, email: email) }
      let(:user_params) { { user: attributes_for(:user, email: email) } }

      it 'returns bad request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create a new user' do
        expect { subject }.not_to change(User, :count)
      end
    end
  end
end
