require 'rails_helper'

RSpec.describe AccountService do
  let!(:user) { create(:user) }

  describe '#withdraw!' do
    subject { AccountService.new(user.account).withdraw!(amount) }

    context 'when amount is positive' do
      let(:amount) { Faker::Number.decimal(l_digits: 2) }

      context 'when user has enough money on the account' do
        before { user.account.update!(balance: amount) }

        it 'decreases the user balance' do
          expect { subject }.to change { user.account.reload.balance }.by(-amount)
        end

        it 'does not call to an external money service' do
          expect_any_instance_of(MoneyTransferService).not_to receive(:transfer)
          subject
        end
      end

      context 'when the user doesnt have enough money on the account' do
        let(:balance) { Faker::Number.between(from: 1, to: (amount - 1)) }

        before do
          user.account.update!(balance: balance)
        end

        it 'reduces user account balance to 0' do
          subject
          expect(user.account.balance).to eq(0)
        end
      end
    end
  end

  describe '#credit!' do
    subject { AccountService.new(user.account).credit!(amount) }
    let(:amount) { Faker::Number.decimal(l_digits: 2) }

    it 'increases the user account balane' do
      expect { subject }.to change { user.account.reload.balance }.by(amount)
    end
  end
end
