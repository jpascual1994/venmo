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
class Friendship < ApplicationRecord
  belongs_to :user_a, class_name: 'User'
  belongs_to :user_b, class_name: 'User'

  validate :not_self_friend
  validate :not_exists_friendship

  private

  def not_self_friend
    return unless user_a == user_b

    errors.add(:base, I18n.t('models.friendship.errors.self_friend'))
  end

  def not_exists_friendship
    exists = Friendship.where(user_a: user_a, user_b: user_b)
                       .or(Friendship.where(user_a: user_b, user_b: user_a))
                       .exists?
    return unless exists

    errors.add(:base, I18n.t('models.friendship.errors.already_exists'))
  end
end
