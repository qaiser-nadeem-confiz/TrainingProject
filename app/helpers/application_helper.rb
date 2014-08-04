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
end
