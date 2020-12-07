class PaymentService
  attr_accessor :user, :params

  def initialize(user)
    @user = user
  end

  def create!(params)
    @params = params

    validate!

    Payment.create!(
      sender: user,
      receiver: friend,
      amount: params[:amount],
      description: params[:description]
    )
  end

  private

  def friend
    User.find(params[:friend_id])
  end

  def validate!
    raise Payments::NotFriendsError unless user.friends.include?(friend)
  end
end
