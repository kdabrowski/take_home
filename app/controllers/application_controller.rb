# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized, except: [:create]

  def encode_token(payload)
    JWT.encode(payload, secret_token)
  end

  def decoded_token
    header = request.headers['Authorization']

    return unless header

    token = header.split(' ').last
    JWT.decode(token, secret_token)
  end

  def authorized
    return true if current_user

    render json: { message: 'Unauthorised' }, status: :unauthorized
  end

  private

  def secret_token
    Rails.application.credentials.jwt[:secret_key]
  end

  def current_user
    return nil unless decoded_token

    @current_user ||= User.find_by(id: decoded_token.first['user_id'])
  end
end
