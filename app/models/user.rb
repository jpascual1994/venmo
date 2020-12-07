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
class User < ApplicationRecord
  has_many :friendships_as_a, class_name: 'Friendship', foreign_key: :user_a_id,
                              inverse_of: :user_a, dependent: :destroy

  has_many :friendships_as_b, class_name: 'Friendship', foreign_key: :user_b_id,
                              inverse_of: :user_b, dependent: :destroy

  has_many :friends_a, through: :friendships_as_a, source: :user_b
  has_many :friends_b, through: :friendships_as_b, source: :user_a

  has_many :sent_payments, class_name: 'Payment', inverse_of: :sender, dependent: :destroy
  has_many :received_payments, class_name: 'Payment', inverse_of: :receiver, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def friends
    friends_a + friends_b
  end
end
