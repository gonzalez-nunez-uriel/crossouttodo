class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :session_string
      t.references :user, null: false, foreign_key: true
      t.datetime :expiration

      t.timestamps
    end
  end
end
