require 'rails_helper'

describe 'GET /api/v1/users/:id/feed', type: :request do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:friend_of_friend) { create(:user) }
  let!(:not_friend) { create(:user) }

  let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }
  let!(:second_grade_frienship) { create(:friendship, user_a: friend, user_b: friend_of_friend) }
  let!(:far_friend) { create(:friendship, user_a: friend_of_friend, user_b: not_friend) }

  let(:params) { {} }
  subject { get feed_api_v1_user_path(user.id), params: params }

  context 'when only exists friends payments' do
    let!(:payments) do
      [
        create(:payment, sender: user, receiver: friend, created_at: Time.zone.today),
        create(:payment, sender: friend, receiver: user, created_at: 1.day.ago),
        create(:payment, sender: friend, receiver: friend_of_friend, created_at: 2.days.ago),
        create(:payment, sender: friend_of_friend, receiver: friend, created_at: 3.days.ago)
      ]
    end

    it 'returns successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns payments ordered by date descending' do
      subject
      expect(response.parsed_body).to include_json(
        feed: payments.map do |payment|
          {
            id: payment.id,
            feed_title: PaymentPresenter.new(payment).feed_title,
            created_at: payment.created_at.iso8601(3)
          }
        end
      )
    end
  end

  context 'when exists far friends payments' do
    let!(:payments) do
      [
        create(:payment, sender: user, receiver: friend, created_at: Time.zone.today),
        create(:payment, sender: friend, receiver: friend_of_friend, created_at: 2.days.ago)
      ]
    end

    let(:not_in_feed) do
      create(:payment, sender: friend_of_friend, receiver: not_friend, created_at: 3.days.ago)
    end

    it 'returns successful response' do
      subject
      expect(response).to be_successful
    end

    it 'only returns payments made by friends up to the second degree' do
      subject
      expect(response.parsed_body).to include_json(
        feed: payments.map do |payment|
          {
            id: payment.id,
            feed_title: PaymentPresenter.new(payment).feed_title,
            created_at: payment.created_at.iso8601(3)
          }
        end
      )
    end
  end

  context 'when there are more than 10 payments' do
    let!(:user) { create(:user) }
    let!(:friend) { create(:user) }
    let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }
    let!(:payments) { create_list(:payment, 15, sender: friend, receiver: user) }

    context 'without page number' do
      it 'returns successful response' do
        subject
        expect(response).to be_successful
      end

      it 'returns up to 10 payments sorted by date' do
        subject
        expect(response.parsed_body).to include_json(
          feed: payments.sort_by { |payment| -payment.created_at.to_i }
                        .first(10)
                        .map do |payment|
                  {
                    id: payment.id,
                    feed_title: PaymentPresenter.new(payment).feed_title,
                    created_at: payment.created_at.iso8601(3)
                  }
                end
        )
      end

      it 'returns pagination info' do
        subject
        expect(response.parsed_body).to include_json(
          pagy: {
            count: 15,
            page: 1,
            items: 10,
            pages: 2,
            next: 2,
            prev: nil
          }
        )
      end
    end

    context 'with page number' do
      let(:params) { { page: 2 } }

      it 'returns successful response' do
        subject
        expect(response).to be_successful
      end

      it 'returns the second page' do
        subject
        expect(response.parsed_body).to include_json(
          feed: payments.sort_by { |payment| -payment.created_at.to_i }
                        .last(5)
                        .map do |payment|
                  {
                    id: payment.id,
                    feed_title: PaymentPresenter.new(payment).feed_title,
                    created_at: payment.created_at.iso8601(3)
                  }
                end
        )
      end

      it 'returns pagination info' do
        subject
        expect(response.parsed_body).to include_json(
          pagy: {
            count: 15,
            page: 2,
            items: 5,
            pages: 2,
            next: nil,
            prev: 1
          }
        )
      end
    end
  end
end
