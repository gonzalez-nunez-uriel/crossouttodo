class CreateErrorSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :error_sessions do |t|
      t.string :error_string
      t.references :user, null: false, foreign_key: true
      t.text :error_code
      t.datetime :expiration

      t.timestamps
    end
  end
end
