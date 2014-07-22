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
end
