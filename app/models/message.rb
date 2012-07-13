class Message < ActiveRecord::Base
 
 	attr_accessible :reciepient_id , :sender_id , :subject , :message

	belongs_to :reciepient, class_name: "User"
	belongs_to :sender, class_name: "User"

 	validates :reciepient_id , presence: true
 	validates :sender_id , presence: true
 	validates :subject , presence: true
 	validates :message , presence: true 
 	
end
