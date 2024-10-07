# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorized, only: [:create]

      def create
        user = User.new(user_params)

        if user.valid?
          user.save

          token = encode_token(user_id: user.id)
          render json: { user: UserSerializer.new(user).serializable_hash, token: token }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:name, :last_name, :password, :email, :user_name)
      end
    end
  end
end
