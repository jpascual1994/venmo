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
class Payment < ApplicationRecord
  MAX_PAYMENT = 1_000
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: MAX_PAYMENT }
  validates :description, presence: true
end
