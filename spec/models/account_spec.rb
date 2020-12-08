# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  balance    :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end
end
