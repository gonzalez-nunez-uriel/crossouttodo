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
end
