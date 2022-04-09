module LoginHelper
    
    def self.generate_new_session_n_cookie user
        new_session = Session.new
        new_session.session_string = generate_session_string
        new_session.user_id = user.id
        new_session.expiration = expiration_time
        new_cookie = { value: new_session.session_string, expires: expiration_time }
        
        return [ new_session, new_cookie ]
    end
    
    private

    def self.generate_session_string
        return rand(1...10**240).to_s
    end

    def self.expiration_time
        1.day.from_now
    end
end
