class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  helper_method def logged_in?
    !!current_user
  end

  helper_method def admin?
    current_user.admin?
  end

  helper_method def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      session[:user_id] = nil
    end
  end

  helper_method def inside?
    case request.env["REQUEST_PATH"]
    when "/","/#page-top","/#services", "/#about", "/logout"
      false
    else
      true
    end
  end
end
