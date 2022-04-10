module LoginHelper
    
    def self.generate_new_session user
        new_session = Session.new
        new_session.session_string = generate_session_string
        new_session.user_id = user.id
        
        return new_session
    end
    
    private

    def self.generate_session_string
        return rand(1...10**240).to_s
    end

end
