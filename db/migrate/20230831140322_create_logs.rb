# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.string :message
      t.timestamps
    end
  end
end
