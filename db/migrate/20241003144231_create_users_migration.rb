# frozen_string_literal: true

class CreateUsersMigration < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
    end
  end
end
