class MessagesController < ApplicationController

	before_filter :signed_in_user , only: [:index,:create,:destroy,:inbox,:sent]
	before_filter :correct_user , only: [:inbox,:sent]

	def index
        @recieved_messages = current_user.recieved_messages.paginate(page: params[:page] ,:per_page => 2)
        @sent_messages = current_user.sent_messages.paginate(page: params[:page] ,:per_page => 2)
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
        @recieved_messages = current_user.recieved_messages.paginate(page: params[:page] ,:per_page => 2)
    end

	def sent
        @sent_messages = current_user.sent_messages.paginate(page: params[:page] ,:per_page => 2)
	end

	 def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
