class User < ActiveRecord::Base
  has_many :organised_events, class_name: 'Event', foreign_key: 'organiser_id'

  has_many :event_participants
  has_many :participating_events, through: :event_participants, source: :event

end
