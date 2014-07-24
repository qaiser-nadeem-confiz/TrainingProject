class Account < ActiveRecord::Base
  validates :emailId , presence: true , length: {minimum: 5 ,maximum:100}  ,format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,message: " is Invalid"}
  validates :userName , presence:true , length: {minimum: 3, maximum:15} ,format: {with: /\A[A-Za-z0-9_]+\z/,message:" is Invalid ,  only alphanumeric and underScore can be included"}
  validates :password , presence:true , length: {minimum:6 , maximum: 20}
end
