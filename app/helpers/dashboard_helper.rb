module DashboardHelper

    def self.generate_new_task user_id, name, summary, description, deadline
        new_task = Task.new
        
        new_task.user_id = user_id
        new_task.name = name
        new_task.summary = if summary != "" then summary else nil end
        new_task.description = if description != "" then description else nil end
        new_task.deadline = if deadline != "" then deadline else nil end

        return new_task
    end

    def self.get_user session_string
        # do I need to initialize this? I rather be safe than sorry
        user = nil
        tasks = nil
        error_rerirect = nil

        if session_string != nil

            browser_session =  Session.find_by( session_string: session_string )    

            if browser_session != nil

                user = User.find( browser_session.user_id )
        
                if user != nil
                    # do nothing
                else
                    error_redirect_url = '/error/user-does-not-exists'
                end
        
            else
                error_redirect_url = '/error/session-not-found'
            end
        else
            error_redirect_url = '/error/not-logged-in'
        end

        return [ error_redirect_url, user ]

    end

    def self.get_pending_tasks user_id
        tasks = Task.where( user_id: user_id, completed: false )
    end

    def self.get_task task_id
        return Task.find(task_id)
    end
end

