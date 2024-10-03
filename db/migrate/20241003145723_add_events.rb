class AddEvents < ActiveRecord::Migration[6.0]
  create_table :events do |t|
    t.string :name
    t.integer :capacity, default: 1
    t.references :organiser_id, foreign_key: { to_table: :users }
  end
end
