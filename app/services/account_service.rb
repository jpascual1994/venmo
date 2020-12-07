class AccountService
  attr_accessor :account

  def initialize(account)
    @account = account
  end

  def withdraw!(amount)
    current_balance = account.balance

    if current_balance < amount
      MoneyTransferService.new(Object.new, account).transfer(amount - current_balance)
    end

    account.reduce_from_balance(amount)
  end

  def credit!(amount)
    return unless amount.positive?

    account.add_to_balance(amount)
  end
end
