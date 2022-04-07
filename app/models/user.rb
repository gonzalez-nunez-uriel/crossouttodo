class User < ApplicationRecord
    # Do I have to provide attribute getters? Things work just fine in the rails console.
    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end
