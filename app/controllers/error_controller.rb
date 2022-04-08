class ErrorController < ApplicationController
    def registration_validation_error
        if cookies[:ValidationError] == nil
            render 'error/registration/generic-validation-error'
        else
            @errors = cookies[:ValidationError]
            render template: 'error/registration/validation-error'
        end
    end

    def registration_password_mismatch
        render template: 'error/registration/password-mismatch'
    end
end
