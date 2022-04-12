class ErrorController < ApplicationController

    

    def registration_validation_error
        if cookies[:ValidationError] == nil
            render 'error/registration/generic-validation-error'
        else
            validation_error
        end
    end

    def task_validation_error
        if cookies[:ValidationError] == nil
            render 'error/bad-task/generic-validation-error'
        else
            validation_error
        end
    end

    def registration_password_mismatch
        render template: 'error/registration/password-mismatch'
    end

    def not_authorized
        render template: 'error/not-authorized'
    end

    private

    def validation_error
        @errors = cookies[:ValidationError]
        render template: 'error/validation-error'
    end

    
end
