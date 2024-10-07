# frozen_string_literal: true

require 'rails_helper'
include LoginHelper

RSpec.describe 'Event requests', type: :request do
  let!(:user) { create(:user, user_name: 'asd123', password: 'password') }
  let!(:token) { generate_token(user) }
  let(:headers) do
    {
      'Authorization' => "Bearer #{token}",
      'Content-Type' => 'application/json'
    }
  end

  describe '#create' do
    context 'when params are valid' do
      let(:params) { { name: 'Some nice event', capcity: 5 }.to_json }

      it 'creates a new event' do
        post '/api/v1/events/create', params: params, headers: headers
        expect(JSON.parse(response.body)['event']).to include(
          'capacity' => 1,
          'name' => 'Some nice event'
        )
      end
    end
  end

  describe '#organised' do
    let!(:user_2) { create(:user, user_name: 'otheruser123', password: 'somepass') }

    let!(:event_organised_1) { create(:event, name: 'Event nr 1', organiser: user) }
    let!(:event_organised_2) { create(:event, name: 'Event nr 2', organiser: user) }
    let!(:event_not_organised) { create(:event, name: 'Some random event', organiser: user_2) }

    it 'fetches organised events' do
      get '/api/v1/events/organised', headers: headers

      expect(JSON.parse(response.body)['events']).to eq([
                                                          { 'capacity' => event_organised_1.capacity,
                                                            'id' => event_organised_1.id, 'name' => 'Event nr 1' },
                                                          { 'capacity' => event_organised_2.capacity,
                                                            'id' => event_organised_2.id, 'name' => 'Event nr 2' }
                                                        ])
    end
  end

  describe '#participants' do
    let!(:user_2) { create(:user, user_name: 'otheruser123', password: 'somepass') }
    let!(:event) { create(:event, name: 'Event nr 1', organiser: user) }
    let(:params) { { event_id: event.id }.to_json }

    before do
      EventParticipant.create(user: user_2, event: event)
    end

    it 'returns participants for a given event' do
      get '/api/v1/events/participants', params: params, headers: headers
      expect(JSON.parse(response.body)['participants']).to eq([{ 'id' => user_2.id, 'user_name' => user_2.user_name }])
    end
  end

  describe '#book' do
    let!(:user_2) { create(:user, user_name: 'otheruser123', password: 'somepass') }
    let!(:event) { create(:event, name: 'Event nr 1', organiser: user) }
    let(:params) { { event_id: event.id } }
    let!(:token) { generate_token(user_2) }

    it 'it books an event' do
      post '/api/v1/events/book', params: params.to_json, headers: headers

      expect(JSON.parse(response.body)['event']).to eq('Event booked')
      expect(user_2.participating_events.count).to eq(1)
    end
  end
end
