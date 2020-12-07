module Api
  module V1
    class UsersController < ApplicationController
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

      private

      def user_params
        params.require(:user).permit(:email, :name)
      end

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
