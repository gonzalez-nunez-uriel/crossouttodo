class DashboardController < ApplicationController
  def dashboard

    error_redirect_url, @user = DashboardHelper.get_user session[ :session_string ]

    if error_redirect_url == nil
      
      @tasks = DashboardHelper.get_pending_tasks @user.id
      
    else
      redirect_to error_redirect_url
    end

  end

  def preferences
    # WILL NOT BE IMPLEMENTED
  end

  def new

  end

  def insert

    error_redirect_url, user = DashboardHelper.get_user session[ :session_string ]

    if error_redirect_url == nil

      begin
        
        new_task = DashboardHelper.generate_new_task user.id, params[:name], params[:summary], params[:description], params[:deadline]
        new_task.save!

        redirect_to '/dashboard'

      rescue ActiveRecord::RecordInvalid => e

        cookies[:ValidationError] = { value: e.to_s, expires: 3.minutes.from_now }
        redirect_to '/error/bad-task/validation-error'
        
      end

    else
      redirect_to error_redirect_url
    end

  end

  def details

    error_redirect_url, user = DashboardHelper.get_user session[ :session_string ]

    if error_redirect_url == nil
      
      @task = DashboardHelper.get_task params[ :id ]

      if @task.user_id == user.id
        # Ready to render
      else
        # maybe add an error cookie? Best to just leave it generic
        redirect_to '/error/not-authorized'
      end
      
    else
      redirect_to error_redirect_url
    end

  end

  def delete
    error_redirect_url, user = DashboardHelper.get_user session[ :session_string ]

    if error_redirect_url == nil
      
      task = DashboardHelper.get_task params[ :task_id ]

      # We must make sure the user has ownership of the task it is trying to delete
      if task.user_id == user.id
        # is it really this simple? I could not find method delete!()
        task.delete
        redirect_to '/dashboard'
        
      else
        # maybe add an error cookie? Best to just leave it generic
        redirect_to '/error/not-authorized'
      end
      
    else
      redirect_to error_redirect_url
    end
  end

end
