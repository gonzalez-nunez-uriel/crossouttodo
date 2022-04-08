class RegisterController < ApplicationController
  def register
  end

  def insert
    if params[:password] == ""
      redirect_to 'error/bad-registration/validation-error'
    elsif params[:password] == params[:password_confirmation]      
      new_user = User.new
      new_user.name = params[:name]
      new_user.username = params[:username]
      new_user.password = params[:password]
      
      begin
        new_user.save!
        redirect_to '/register/success'

      rescue ActiveRecord::RecordInvalid => e
        # It would be nice to have an error that can handle the case where the username already exists
        # An error session is needed here
        redirect_to 'error/bad-registration/validation-error'  
      end
    else
      redirect_to 'error/bad-registration/password-mismatch'
    end
  end
end
