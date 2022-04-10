class RemoveExpirationFromSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :expiration, :datetime
  end
end
