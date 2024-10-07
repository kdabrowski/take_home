# frozen_string_literal: true

module LoginHelper
  def generate_token(user)
    secret_token = Rails.application.credentials.jwt[:secret_key]
    JWT.encode({ user_id: user.id }, secret_token)
  end
end
