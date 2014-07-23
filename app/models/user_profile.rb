class UserProfile < ActiveRecord::Base

  has_many :comments ,dependent: :destroy
  has_many :notifications ,dependent: :destroy
  validates :firstName , presence:true , length: {minimum: 1, maximum:20}
  validates :secondName , presence:true , length: {minimum:1 , maximum: 20}
  validates :secondName , presence:true , length: {minimum:3 , maximum: 100}
  validates :education , presence:true ,length:{maximum:50}
  validates :accountType , presence:true
  validates :isActive , presence: true
  validates :aboutMe ,length: {maximum: 200}
  validates :emailId , presence: true , length: {minimum: 5 ,maximum:100}
  validates :userName , presence:true , length: {minimum: 3, maximum:15}

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
    "/Users/Photoes/"+self.emailId+"/"+file.original_filename
  end

  def savePhoto(file)
    uploaded_file = file
    folder=handleDirectoryMaking
    File.open(folder+uploaded_file.original_filename, 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end

  def handleDirectoryMaking
    dir = File.dirname("#{Rails.root}/public/Users/Photoes/temp")
    FileUtils.mkdir_p(dir+"/"+self.emailId)
    return dir+'/'+self.emailId+"/"
  end

end
