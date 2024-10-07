# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      def create
        event = Event.new(event_params)
        event.organiser_id = current_user.id

        if event.valid?
          event.save
          render json: { event: EventSerializer.new(event).serializable_hash }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def organised
        events = current_user.organised_events
        render json: { events: events.map { EventSerializer.new(_1).serializable_hash } }
      end

      def participating
        events = current_user.participating_events
        render json: { events: events.map { EventSerializer.new(_1).serializable_hash } }
      end

      def book
        event = Event.find_by(id: params[:event_id])

        return render json: { error: 'Event not found' }, status: :not_found if event.nil?

        success = ActiveRecord::Base.transaction do
          return false if event.capacity == event.participants.count

          ::EventParticipant.create(event_id: event.id, user_id: current_user.id)
        end

        if success
          render json: { event: 'Event booked' }, status: :created
        else
          render json: { error: 'Event is fully booked' }, status: :unprocessable_entity
        end
      end

      def participants
        event = Event.find_by(organiser_id: current_user.id)

        return render json: { error: 'Event not found' }, status: :not_found unless event

        participants = event.participants
        render json: { participants: participants.map { UserSerializer.new(_1).serializable_hash } }
      end

      private

      def event_params
        params.permit(:name, :capacity, :event_id)
      end
    end
  end
end
