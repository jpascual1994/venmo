module Api
  module V1
    module Users
      class PaymentsController < ApplicationController
        def create
          PaymentService.new(user).create!(payment_params)
          head :no_content
        end

        private

        def payment_params
          params.require(:payment).permit(:friend_id, :amount, :description)
        end

        def user
          User.find(params[:user_id])
        end
      end
    end
  end
end
