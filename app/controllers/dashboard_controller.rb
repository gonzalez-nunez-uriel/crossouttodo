class DashboardController < ApplicationController
  def dashboard
    if cookies[:session_string] != nil
      
      session =  Session.find_by( session_string: cookies[ :session_string ] )
      
      if session != nil

        @user = User.find( session.user_id )

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
