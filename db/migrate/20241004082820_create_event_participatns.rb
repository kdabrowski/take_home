# frozen_string_literal: true

class CreateEventParticipatns < ActiveRecord::Migration[6.0]
  def change
    create_table :event_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
    end
  end
end
