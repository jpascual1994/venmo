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
class Account < ApplicationRecord
  belongs_to :user

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def add_to_balance(amount)
    self.balance += amount
    save!
  end

  def reduce_from_balance(amount)
    self.balance -= amount
    save!
  end
end
