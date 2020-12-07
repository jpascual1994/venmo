module Api
  module V1
    class UsersController < ApplicationController
      include Pagy::Backend

      helper_method :user

      def show; end

      def create
        @user = User.create!(user_params)
        render :show
      end

      def balance
        balance = user.account_balance
        render json: { balance: balance }, status: :ok
      end

      def feed
        payments = PaymentService.new(user).feed_payments
        @pagy, @payments = pagy(payments, page: page)
        @payments = @payments.by_date.map do |payment|
          PaymentPresenter.new(payment)
        end

        @metadata = pagy_metadata(@pagy)
      end

      private

      def user_params
        params.require(:user).permit(:email, :name)
      end

      def user
        @user ||= User.find(params[:id])
      end

      def page
        params[:page] || 1
      end
    end
  end
end
