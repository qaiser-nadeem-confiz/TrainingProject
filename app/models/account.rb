class Account < ActiveRecord::Base
  validates :emailId , presence: true , length: {minimum: 5 ,maximum:100}  ,format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,message: " is Invalid"}
  validates :userName , presence:true , length: {minimum: 3, maximum:15} ,format: {with: /\A[A-Za-z0-9_]+\z/,message:" is Invalid ,  only alphanumeric and underScore can be included"}
  validates :password , presence:true , length: {minimum:6 , maximum: 20}




  def authorizeAccount enteredPassword
  @accountByEmail=Account.where("emailId='"+self.emailId+"'")
  @accountByUserName=Account.where("userName= ?",self.userName)
  if(@accountByEmail.length>0)
    return  "Email Id Already Exists"
  elsif @accountByUserName.length>0
      return "User Name already exists"
  elsif(self.password.to_s!=enteredPassword)
    return  "Password does not match"
  end
  if self.save
    return true
  else
    self.valid?
    return false
  end
  end


  def self.findAccount (account)
    @accountByEmail = Account.find_all_by_emailId(account.userName)
    @accountByUserName=Account.find_all_by_userName(account.userName)
    if(@accountByEmail.length>0)
      return @accountByEmail[0]
    elsif(@accountByUserName.length>0)
      return @accountByUserName[0]
    else return nil
    end
  end


end
