module ApplicationHelper


  def alreadyFriend? (from , to)


    @friends=FriendList.where("(userId="+to.to_s+" and friendsWithId = "+from.to_s + ") or (userId="+from.to_s+" and friendsWithId = "+to.to_s+")")
    if @friends.length>0
      return true
    else return false
    end
  end

  def requestAlreadySent? (from ,to)
    @requests= FriendRequest.where("(requestTo = '"+to.userName+"' and requestFrom = '"+from.userName+"') or
    (requestTo = '"+from.userName+"' and requestFrom = '"+to.userName+"')")
    if(@requests.length>0)
      return true
    else return false
    end

    

  end
end
