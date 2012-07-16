class MessagesController < ApplicationController

	def index
        @recieved_messages = current_user.recieved_messages
        @sent_messages = current_user.sent_messages
	end

	

	def create
		@message = Message.new(params[:message])
		if @message.save			
		    flash[:success] = "Message Sent Successfully."
		    redirect_to messages_path
		else		
		    @user = User.find(params[:message][:reciepient_id])
		    @microposts = @user.microposts.paginate(page: params[:page])		
			render "users/show" 
		end	
	end

	def destroy

	    Message.find_by_id(params[:id]).destroy
	    flash[:success] = "Message deleted successfully"
	    redirect_to messages_path

	end

	def inbox
        @recieved_messages = current_user.recieved_messages
    end

	def sent
        @sent_messages = current_user.sent_messages
	end

end
