module SessionsHelper
  def sign_in(user)
      cookies.permanent[:remember_token] = user.remember_token
      self.current_user = user
    end

    def signed_in?
      current_user
      !self.current_user.nil?
    end

  def sign_out
      self.current_user = nil
      cookies.delete(:remember_token)
    end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  #Listing 9.18: code for friendly forwarding
  def store_location
    #request obj gets full path of requested pg, stores in session var
    session[:return_to] = request.fullpath
  end
  def redirect_back_or(default)
    #using session var or whatever default is to send user there
    redirect_to(session[:return_to] || default)
    #then deleting this session var? I would think this would have session[  ???????
    session.delete(:return_to)
  end


end
