require 'rails_helper'

describe 'POST /api/v1/users/:user_id/payments', type: :request do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }

  subject { post api_v1_user_payments_path(user), params: params }

  context 'when params are valid' do
    let(:params) { { payment: attributes_for(:payment).merge(friend_id: friend.id) } }

    context 'when users are friends' do
      let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }

      it 'returns successful response' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'creates a payment' do
        expect { subject }.to change(Payment, :count).by(1)
      end
    end

    context 'when users are not friends' do
      it 'returns bad request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create a payment' do
        expect { subject }.not_to change(Payment, :count)
      end

      it 'returns an error message' do
        subject
        expect(response.parsed_body).to include_json(
          errors: 'Payments are only allowed between friends'
        )
      end
    end
  end

  context 'when params are invalid' do
    let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }

    context 'when friend does not exits' do
      let(:params) { { payment: attributes_for(:payment).merge(friend_id: nil) } }

      it 'returns a failure response' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'does not create a payment' do
        expect { subject }.not_to change(Payment, :count)
      end

      it 'returns an error message' do
        subject
        expect(response.parsed_body).to include_json(
          error: "Couldn't find the record"
        )
      end
    end

    context 'when amount is invalid' do
      let(:params) do
        {
          payment: attributes_for(:payment, amount: amount).merge(friend_id: friend.id)
        }
      end

      context 'when amount is 0' do
        let(:amount) { 0 }

        it 'returns failure response' do
          subject
          expect(response).to have_http_status(:bad_request)
        end

        it 'does not create a payment' do
          expect { subject }.not_to change(Payment, :count)
        end

        it 'returns an error message' do
          subject
          expect(response.parsed_body).to include_json(
            errors:
            {
              amount: contain_exactly('must be greater than 0')
            }
          )
        end
      end

      context 'when amount is 1000' do
        let(:amount) { 1_000 }

        it 'returns bad request' do
          subject
          expect(response).to have_http_status(:bad_request)
        end

        it 'does not create a payment' do
          expect { subject }.not_to change(Payment, :count)
        end

        it 'returns an error message' do
          subject
          expect(response.parsed_body).to include_json(
            errors:
            {
              amount: contain_exactly('must be less than 1000')
            }
          )
        end
      end
    end
  end
end
