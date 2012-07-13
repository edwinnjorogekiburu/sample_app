class UsersController < ApplicationController


  before_filter :signed_in_user, only: [:index, :edit, :update ,:destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @message=Message.new
  end

  def index
  if params[:search]
    @users = User.paginate(page: params[:page],:conditions => ['name LIKE?', "%#{params[:search]}%"])  
    @count = @users.count
  else
    @users = User.paginate(page: params[:page])
  end
  end

  def new
     if !signed_in?
      @user = User.new
    else
      redirect_to root_path
    end
  end

   def create

    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      UserMailer.registration_confirmation(@user).deliver
      sign_in(@user,1)
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Update Successful"
      sign_in(@user,1)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  if !current_user?(User.find(params[:id]))
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  else
      flash[:notice] = "User destroy failed: You cannot delete your own account." 
      redirect_to users_path
  end

  
  end

   def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end


end
