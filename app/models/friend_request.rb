class FriendRequest < ActiveRecord::Base





  def alreadyFriend? (from , to)
    @friends=FriendList.where("(userId="+to.id.to_s+" and friendsWithId = "+from.id.to_s + ") or (userId="+from.id.to_s+" and friendsWithId = "+to.id.to_s+")")
    if @friends.length>0
      return true
      else return false
    end
  end



  def requestAlreadySent? (from ,to)
    @requests= FriendRequest.where("(requestTo = '"+to.userName+"' and requestFrom = '"+from.userName+"') or
    (requestTo = '"+from.userName+"' and requestFrom = '"+to.userName+"')")
    if(@requests.nil?)
      return false
    else return true
    end

  end


end
