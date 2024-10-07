# frozen_string_literal: true

class AddEvents < ActiveRecord::Migration[6.0]
  create_table :events do |t|
    t.string :name
    t.integer :capacity, default: 1
    t.references :organiser, foreign_key: { to_table: :users }
  end
end
