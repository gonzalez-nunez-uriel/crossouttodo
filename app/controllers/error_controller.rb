class ErrorController < ApplicationController
    def registration_validation_error
        render template: 'error/registration/validation-error'
    end

    def registration_password_mismatch
        render template: 'error/registration/password-mismatch'
    end
end
