class FriendList < ActiveRecord::Base
  def makeFriend (friend , friendWith)
    self.dateOfFriendShip=Date.today
    self.friendsWithId=friendWith.id
    self.userId=friend.id
    self.requestAccepted=true
    self.save
  end

  def self.unfriend (friend , friendWith)
    @friendList=findFriend friend , friendWith
    if @friendList.nil?
      return false
    else FriendList.delete @friendList.id
      return true
    end
  end


  def self.getFriendsProfiles (userProfile)
   @friends1 = FriendList.find_all_by_friendsWithId(userProfile.id).map { |x| x.userId}
   @friends2=FriendList.find_all_by_userId(userProfile.id).map { |x| x.friendsWithId}
    @FriendsProfiles=UserProfile.where("id in (?) or id in (?)" ,@friends1,@friends2)
    return @FriendsProfiles
  end

=begin
  def self.getFriendsProfiles (userProfile)
  @allFriends= UserProfile.where("id in (SELECT userId FROM friend_lists WHERE (friendsWithId=#{userProfile.id}))
  or id in (SELECT friendsWithId FROM friend_lists WHERE (userId=#{userProfile.id}))")
  return @allFriends
  end
=end
  private
  def self.findFriend (friend , friendWith)
  @friends=  FriendList.where("(friendsWithId= #{friendWith.id} and userId=#{friend.id}) or
    (friendsWithId= #{friend.id} and userId=#{friendWith.id})")
    if @friends.length>0
      return @friends[0]
      else return nil
      end
  end
end
