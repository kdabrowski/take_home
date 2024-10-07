# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth requests', type: :request do
  describe '#login' do
    context 'with valid params' do
      let(:user) { create(:user, user_name: 'ume123', password: 'Pa$$word') }
      let(:params) do
        {
          user_name: user.user_name,
          password: user.password
        }
      end

      it 'logs in the user' do
        post '/api/v1/auth/login', params: params

        expect(JSON.parse(response.body).keys).to eq(%w[user token])
      end
    end
  end
end
