require 'rails_helper'

describe 'GET /api/v1/users/:id/balance' do
  subject { get balance_api_v1_user_path(id) }

  context 'when user exists' do
    let(:account_balance) { Faker::Number.decimal(l_digits: 2) }
    let!(:user) { create(:user) }
    let(:id) { user.id }

    before do
      user.account.update!(balance: account_balance)
      subject
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'return the user balance' do
      expect(response.parsed_body).to include_json(balance: account_balance)
    end
  end

  context 'when user does not exists' do
    let(:id) { 1234 }

    before { subject }

    it 'returns not_found' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns an error message' do
      expect(response.parsed_body).to include_json(error: "Couldn't find the record")
    end
  end
end
