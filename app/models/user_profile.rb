class UserProfile < ActiveRecord::Base

  has_many :comments ,dependent: :destroy
  has_many :notifications ,dependent: :destroy
  validates :firstName , presence:true , length: {minimum: 1, maximum:20} , format: { with: /\A[a-zA-Z]+\z/,
                                                                                    message: " is Invalid" }
  validates :secondName , presence:true , length: {minimum:1 , maximum: 20} , format: { with: /\A[a-zA-Z]+\z/,
                                                                                        message: "is Invalid" }
  validates :secondName , presence:true , length: {minimum:3 , maximum: 100}
  validates :education , presence:true ,length:{maximum:50} , format: { with: /\A[a-zA-Z]+\z/,
                                                                        message: " is Invalid" }
  validates :accountType , presence:true
  validates :isActive , presence: true
  validates :aboutMe ,length: {maximum: 200}
  validates :emailId , presence: true , length: {minimum: 5 ,maximum:100}
  validates :userName , presence:true , length: {minimum: 3, maximum:15}
  validates :phoneNumber, length:{maximum: 14} , format: {with: /\A\+?[0-9]*\z/ ,message: " is Invalid"}

  def requestAlreadySent? (from ,to)
    @requests= FriendRequest.where("(requestTo = '"+to.userName+"' and requestFrom = '"+from.userName+"') or
    (requestTo = '"+from.userName+"' and requestFrom = '"+to.userName+"')")
    if(@requests.nil?)
      return false
    else return true
    end
  end

def requestedFriendship? (from)
  @requests= getRequestFrom from
  if @requests.nil?
    return false
    else return true
  end
end

def acceptFriendRequest(friend)
  if requestedFriendship? friend
    @friend_list=FriendList.new

   if @friend_list.makeFriend self,friend
    deleteFriendRequest friend
    return true
   else return false
   end

  else
    return false
  end
end

def rejectFriendRequest(from)
deleteFriendRequest from
end

  def initializeAttributess(email,userName,file)
    self.accountType='Normal'
    self.isActive=true
    self.emailId=email
    self.userName=userName
    self.dateOfJoining=Date.today
    if(file)
      self.pictureUrl=getPictureUrl file
    end
  end

  def getPictureUrl file
    "/Users/Photoes/"+self.emailId+"/"+file.original_filename+".png"
  end

  def savePhoto(file)
    uploaded_file = file
    folder=handleDirectoryMaking
    File.open(folder+uploaded_file.original_filename+".png", 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end

  def handleDirectoryMaking
    dir = File.dirname("#{Rails.root}/public/Users/Photoes/temp")
    FileUtils.mkdir_p(dir+"/"+self.emailId)
    return dir+'/'+self.emailId+"/"
  end


  def getPendingRequestsProfiles
  @pendingFriends =UserProfile.where("userName in (SELECT requestFrom FROM friend_requests WHERE requestTo = '#{self.userName}')")
    return @pendingFriends
  end

  private
  def deleteFriendRequest from
    @request=getRequestFrom from
    if(@request)
      FriendRequest.delete(@request.id)
      return true
    else return false
    end
  end

  private
  def getRequestFrom from
    @requests= FriendRequest.where("(requestTo = '"+self.userName+"' and requestFrom = '"+from.userName+"')")
    if(@requests.length>0)
      return @requests[0]
    else return nil
    end
  end

end
