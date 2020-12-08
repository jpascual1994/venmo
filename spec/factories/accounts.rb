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
FactoryBot.define do
  factory :account do
    user
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
