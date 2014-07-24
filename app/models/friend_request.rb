class FriendRequest < ActiveRecord::Base

  def alreadyFriend? (from , to)
    @friends=FriendList.where("(userId="+to.id.to_s+" and friendsWithId = "+from.id.to_s + ") or (userId="+from.id.to_s+" and friendsWithId = "+to.id.to_s+")")
    if @friends.length>0
      return true
      else return false
    end
  end



  def self.requestAlreadySent? (from ,to)
    @requests= FriendRequest.where("(requestTo = '"+to.userName+"' and requestFrom = '"+from.userName+"') or
    (requestTo = '"+from.userName+"' and requestFrom = '"+to.userName+"')")
    if(@requests.length<=0)
      return false
    else return true
    end

  end




  def self.getPendingRequests profile
    @requests= FriendRequest.where("(requestTo = '"+profile.userName+"'")
  end

  def saveRequest (sender , requestTo)
    self.requestFrom=sender.userName
    self.requestTo=requestTo.userName
    self.save
  end

end
