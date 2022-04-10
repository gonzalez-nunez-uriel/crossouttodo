class Session < ApplicationRecord
  belongs_to :user

  validates :session_string, presence: true
  validates :user_id, presence: true
  
end
