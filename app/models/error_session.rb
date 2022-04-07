class ErrorSession < ApplicationRecord
  belongs_to :user

  validates :error_string, presence: true
  validates :user_id, presence: true
  validates :error_code, presence: true
  validates :expiration, presence: true
end
