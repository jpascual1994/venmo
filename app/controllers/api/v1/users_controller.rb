module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.find(params[:id])
      end

      def create
        @user = User.create!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(:email, :name)
      end
    end
  end
end
