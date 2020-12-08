class PaymentService
  attr_accessor :user, :params

  def initialize(user)
    @user = user
  end

  def create!(params)
    @params = params

    validate!

    ActiveRecord::Base.transaction do
      withdraw_from_user
      send_money_to_friend
      create_payment
    end
  end

  def feed_payments
    Payment.made_by(user.friends.pluck(:id))
  end

  private

  def friend
    @friend ||= User.find(params[:friend_id])
  end

  def validate!
    raise Payments::NotFriendsError unless user.friends.include?(friend)
  end

  def create_payment
    Payment.create!(
      sender: user,
      receiver: friend,
      amount: amount,
      description: params[:description]
    )
  end

  def withdraw_from_user
    AccountService.new(user.account).withdraw!(amount.to_f)
  end

  def send_money_to_friend
    AccountService.new(friend.account).credit!(amount.to_f)
  end

  def amount
    @amount ||= params[:amount].to_f
  end
end
