# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associatins' do
    it {
      is_expected.to have_many(:friendships_as_a).class_name('Friendship')
                                                 .inverse_of(:user_a).dependent(:destroy)
    }

    it {
      is_expected.to have_many(:friendships_as_b).class_name('Friendship')
                                                 .inverse_of(:user_b).dependent(:destroy)
    }

    it { is_expected.to have_many(:friends_a).through(:friendships_as_a).source(:user_b) }
    it { is_expected.to have_many(:friends_b).through(:friendships_as_b).source(:user_a) }
  end

  describe 'validations' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#friends' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:user4) { create(:user) }

    before do
      create(:friendship, user_a: user1, user_b: user2)
      create(:friendship, user_a: user3, user_b: user1)
      create(:friendship, user_a: user3, user_b: user4)
    end

    subject { user1.friends }

    it 'contains user friends' do
      expect(subject).to include(user2, user3)
    end

    it 'does not contain no friends' do
      expect(subject).not_to include(user4)
    end
  end
end
