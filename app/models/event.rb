# frozen_string_literal: true

class Event < ActiveRecord::Base
  belongs_to :organiser, class_name: 'User'

  has_many :event_participants
  has_many :participants, through: :event_participants, source: :user
end
