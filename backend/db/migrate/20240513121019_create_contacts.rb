# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :shortname
      t.string :fullname
      t.string :email
    end

    add_index :contacts, :shortname, unique: true
  end
end
