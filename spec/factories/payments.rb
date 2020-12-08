# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  description :text             default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint
#  sender_id   :bigint
#
# Indexes
#
#  index_payments_on_receiver_id  (receiver_id)
#  index_payments_on_sender_id    (sender_id)
#
FactoryBot.define do
  factory :payment do
    sender factory: :user
    receiver factory: :user
    amount { Faker::Number.within(range: 1..1_000).to_f }
    description { Faker::Lorem.sentence }
    created_at { Faker::Date.backward }
  end
end
