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

  def current_user 
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorized
    return unless !!current_user

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  private

  def secret_token
    Rails.application.credentials.jwt[:secret_key]
  end
end
