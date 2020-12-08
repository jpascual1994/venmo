class PaymentPresenter
  delegate :id, :created_at, :description, :sender_name, :receiver_name, to: :@payment

  def initialize(payment)
    @payment = payment
  end

  def feed_title
    I18n.t('models.payment.presenter.feed_title', sender: sender_name,
                                                  receiver: receiver_name,
                                                  date: date,
                                                  description: description)
  end

  private

  def date
    @payment.created_at.strftime('%b %d, %Y')
  end
end
