class ApplicationController < ActionController::Base
  protect_from_forgery


  protected
  def findAccount (account)
    @accountByEmail = Account.find_all_by_emailId(account.userName)
    @accountByUserName=Account.find_all_by_userName(account.userName)
    if(@accountByEmail.length>0)
      return @accountByEmail[0]
    elsif(@accountByUserName.length>0)
      return @accountByUserName[0]
    else return nil
    end
  end

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
  protected
  def user_has_loged_in?
    if session[:loged_in?]
      return true
    else return false
    end
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

  def getProfile
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
end
