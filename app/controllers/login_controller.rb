class LoginController < ApplicationController

    def authenticate
        if params[:username] != nil and params[:password] != nil
            @user = User.find_by(username: params[:username])
            if @user != nil
                if @user.password == params[:password]
                    # Since the homepage can detect if a user has a valid session, then a user accessing this page is guaranteed to not have a session
                    # Therefore, there is no need to check if there exists a session with this user.
                    server_session = LoginHelper.generate_new_session @user
                    server_session.save!
                    session[:session_string] = server_session.session_string
                    redirect_to '/dashboard'
                else
                    redirect_to '/error/bad-login/wrong-password'
                end
            else
                redirect_to '/error/bad-login/user-does-not-exists'
            end
        else
            redirect_to '/error/bad-login/missing-field'
        end
    end
end
