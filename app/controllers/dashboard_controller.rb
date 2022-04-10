class DashboardController < ApplicationController
  def dashboard
    if session[:session_string] != nil
      
      browser_session =  Session.find_by( session_string: session[ :session_string ] )
      
      if browser_session != nil

        @user = User.find( browser_session.user_id )

        if @user != nil
          # TO BE IMPLEMENTED
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
end
