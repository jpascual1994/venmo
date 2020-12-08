# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_a_id  :bigint
#  user_b_id  :bigint
#
# Indexes
#
#  index_friendships_on_user_a_id  (user_a_id)
#  index_friendships_on_user_b_id  (user_b_id)
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user_a).class_name('User') }
    it { is_expected.to belong_to(:user_b).class_name('User') }
  end

  describe 'validations' do
    describe 'not_self_friend' do
      let(:user) { create(:user) }

      subject { create(:friendship, user_a: user, user_b: user) }

      it 'raises an invalid record error' do
        expect { subject }
          .to raise_error(ActiveRecord::RecordInvalid, /Users should be different each other/)
      end
    end

    describe 'not_exists_friendship' do
      context 'when the friendship does not exists' do
        subject { create(:friendship) }

        it 'create a new friendship' do
          expect { subject }.to change(Friendship, :count).by(1)
        end
      end

      context 'when the friendship already exits' do
        let!(:friendship) { create(:friendship) }
        let(:user_a) { friendship.user_a }
        let(:user_b) { friendship.user_b }

        context 'when the users are in the same order' do
          subject { create(:friendship, user_a: user_a, user_b: user_b) }

          it 'raises an invalid record error' do
            expect { subject }
              .to raise_error(ActiveRecord::RecordInvalid, /The Friendship already exists/)
          end
        end

        context 'when the order is inverted' do
          subject { create(:friendship, user_a: user_b, user_b: user_a) }

          it 'raises an invalid record error' do
            expect { subject }
              .to raise_error(ActiveRecord::RecordInvalid, /The Friendship already exists/)
          end
        end
      end
    end
  end
end
