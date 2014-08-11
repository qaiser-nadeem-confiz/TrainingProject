module ApplicationHelper
  def userHimself? from , to
    return from==to
  end

  def alreadyFriend? (from , to)
    @friends=FriendList.where("(userId="+to.to_s+" and friendsWithId = "+from.to_s + ") or (userId="+from.to_s+" and friendsWithId = "+to.to_s+")")
    if @friends.length>0
      return true
    else return false
    end
  end

  def requestAlreadySent? (from ,to)
    FriendRequest.requestAlreadySent? from , to
    end

   def currenttlyLoggedInUser? (profile)
     return session[:userName]== profile.userName
   end
  def user_has_loged_in?
    if session[:loged_in?]
      return true
    else return false
    end
  end


def getCurrentUser
  getProfile
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



end
