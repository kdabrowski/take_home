# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorized, only: [:login]

      def login
        @user = User.find_by!(user_name: login_params[:user_name])

        if @user.authenticate(login_params[:password])
          @token = encode_token(user_id: @user.id)

          render json: {
            user: UserSerializer.new(@user),
            token: @token
          }, status: :accepted
        else
          render json: { message: 'Incorrect password' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:user_name, :password)
      end
    end
  end
end
