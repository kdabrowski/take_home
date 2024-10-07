# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    organiser { :user }
    capacity { Random.rand(10) }
  end
end
