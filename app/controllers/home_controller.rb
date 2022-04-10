class HomeController < ApplicationController
  def index
    if session[:session_string] != nil
      @session_exists = true
    else
      @session_exists = false
    end
  end
end
