class ApplicationController < ActionController::Base
  protect_from_forgery




  protected
  def authenticateUser(loginDetails,foundedAccount)
    return loginDetails.password==foundedAccount.password
  end


  protected
  def require_login
    unless user_has_loged_in?
      flash[:errorMessage] = "You must be logged in to access this section"
      session[:requestedUrl]=request.url
      redirect_to :action => 'login' , :controller => 'home'
    end
  end
  public
  def user_has_loged_in?
    if session[:loged_in?]
      return true
    else return false
    end
  end


  protected
  def set_error_message (message)
    flash[:errorMessage] = message
  end

  protected
  def set_notice (message)
    flash[:message] =message
  end

  protected
  def getEmail
    return session[:emailId]
  end

  protected
  def getUserName
    return session[:userName]
  end

  protected
  def getCurrentUser
    if profileAlreadyExists?
      return UserProfile.find_by_emailId(getEmail)
    else nil
    end
  end

  protected

  def profileAlreadyExists?
    return UserProfile.find_all_by_emailId(getEmail).length>0
  end

  protected
  def getProfileByUserName userName
    if UserProfile.find_all_by_userName(userName).length>0
      return UserProfile.find_by_userName(userName)
      else return nil?
    end
  end


  protected
  def profile_added?
    if getCurrentUser.nil?
      flash[:errorMessage] = "Kindly Add your profile informations first"
      redirect_to action: 'new' , controller: 'user_profiles'
    end
  end
end
