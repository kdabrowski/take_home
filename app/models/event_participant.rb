# frozen_string_literal: true

class EventParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
