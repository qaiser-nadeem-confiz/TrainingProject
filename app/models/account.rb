class Account < ActiveRecord::Base
  validates :emailId , presence: true , length: {minimum: 5 ,maximum:100}
  validates :userName , presence:true , length: {minimum: 3, maximum:15}
  validates :password , presence:true , length: {minimum:6 , maximum: 20}
end
