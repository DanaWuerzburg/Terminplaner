class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method	:current_user_session,	:current_user  , :current_group


  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def current_group
    return @current_group if defined?(@current_group)
    @current_group = Group.find
  end

   def current_colour
    return @current_colour if defined?(@current_colour)
    @current_colour = current_group.colour
  end

   def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to appointments_url
        return false
      end
    end

    def store_location
      # puts request.fullpath
      session[:return_to] = request.fullpath

    end

   def require_admin
    # raise User::NotAuthorized unless current_user.admin?
     unless current_user.admin?
        store_location
        flash[:notice] = "You are not authorized to access this page"
        redirect_to appointments_url
        return false
      end
   end



end
