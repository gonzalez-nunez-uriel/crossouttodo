class HomeController < ApplicationController
  def index

    if session[:session_string] != nil

      browser_session =  Session.find_by( session_string: session[ :session_string ] )

      if browser_session != nil

        @user = User.find( browser_session.user_id )

        if @user != nil
          @user_exists = true
        else
          @user_exists = false
        end

      else
        @user_exists = false
      end

    else
      @user_exists = false
    end
  end
end