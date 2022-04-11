class DashboardController < ApplicationController
  def dashboard
    if session[:session_string] != nil
      
      browser_session =  Session.find_by( session_string: session[ :session_string ] )
      
      if browser_session != nil

        @user = User.find( browser_session.user_id )

        if @user != nil
          @tasks = Task.where( user_id: @user.id )
        else
          redirect_to '/error/user-no-longer-exists'
        end

      else
        redirect_to '/error/no-session-found'
      end

    else
      redirect_to '/error/not-logged-in'
    end
  end

  def preferences
    # WILL NOT BE IMPLEMENTED
  end

  def new

  end

  def insert

    if session[:session_string] != nil

      browser_session = Session.find_by( session_string: session[ :session_string ] )

      if browser_session != nil

        user = User.find( browser_session.user_id )

        if user != nil

          begin
            new_task = DashboardHelper.generate_new_task user.id, params[:name], params[:summary], params[:description], params[:deadline]
            new_task.save!
  
            redirect_to '/dashboard'

          rescue ActiveRecord::RecordInvalid => e

            cookies[:ValidationError] = { value: e.to_s, expires: 3.minutes.from_now }
            redirect_to '/error/bad-task/validation-error'
            
          end

        else
          redirect_to 'error/user-does-not-exists'
        end

      else
        redirect_to 'error/session-not-found'
      end

    else
      redirect_to 'error/not-logged-in'
    end

  end

end
