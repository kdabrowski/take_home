# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.valid?
      user.save

      @token = encode_token(user_id: user.id)
      render json: {
        user: UserSerializer.new(user),
        token: @token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :last_name, :password, :email, :user_name)
  end
end
