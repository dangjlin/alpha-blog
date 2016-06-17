class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  
  def logged_in?
    !!current_user
  end
  
  #In Ruby, the only two things that evaluate to false are false (itself) and nil.
  #If you negate something, that forces a boolean context. Of course, it also negates it. If you double-negate it, it forces the boolean context, but returns the proper boolean value.
  #For example:

  #  "hello"   #-> this is a string; it is not in a boolean context
  #  !"hello"  #-> this is a string that is forced into a boolean 
  #            #   context (true), and then negated (false)
  #  !!"hello" #-> this is a string that is forced into a boolean 
  #            #   context (true), and then negated (false), and then 
  #            #   negated again (true)
  #  !!nil     #-> this is a false-y value that is forced into a boolean 
  #            #   context (false), and then negated (true), and then 
  #            #   negated again (false)
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
  
  
end
