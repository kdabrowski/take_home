require 'rails_helper'

RSpec.describe 'user requests', type: :request do
  let(:params) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'example@email.com',
      user_name: 'TestUser',
      password: 'Password1'
    }
  end
 
  describe '#crate' do
    subject { post '/api/v1/users/create', params: params }
    it 'creates a new user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'returns user data' do
      subject

      expect(JSON.parse(response.body)["user"]).to include(
        'user_name' => 'TestUser',
        'email' => 'example@email.com'
      )
    end
  end
end
