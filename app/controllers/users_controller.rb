class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] #Listing 9.22: index action now part of before filter
  #Listing 9.46, adding :destroy action stuff
  before_filter :correct_user, only: [:edit, :update]

  #Listing 9.48: restricting destroy action to admins
  before_filter :admin_user, only: :destroy

  #Chapter 9 Ex. 6: before filter for redirecting new/create if logged in
  before_filter :signed_in_user_filter, only: [:new, :create]
  def signed_in_user_filter
      if signed_in?
          redirect_to root_path, notice: "Already logged in"
      end
  end

  def destroy
    #Chapter 9 Ex 9: preventing user from deleting themselves
    #my code doesn't seem to allow that anyway
    unless current_user?(User.find(params[:id]))
      #Listing 9.46: adding destroy action stuff
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
    else
      flash[:error] = "You can't delete yourself"
    end
    redirect_to users_url
  end

  def admin_user
    #Listing 9.48: making admin only able to delete
    redirect_to(root_url) unless current_user.admin?
  end

  def index #Listing 9.22: defining index action for displaying all users
    #Listing 9.24 - put all users from db into var
    #@users = User.all

    #Listing 9.35: paginating. (change default = :per_page => 2.)
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    #10,22: making @mps instance var for user SHOW action
    #NOTE: i was missing gems for paginate!
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App"
        redirect_to @user
      else
        render 'new'
      end

  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  #Chap 9 #1:why do I have to have this? :admin is already defined?
  #def user_params
  #    params.require(:user).permit(:name, :email, :password,
  #                                 :password_confirmation, :admin)
  #  end
    def signed_in_user
      #Listing 9.19 using store_location
      unless signed_in?
      #*** THIS DIDN'T WORK ***
      #  #Chapter 9 Ex 6: redirected if trying to do a create & already signed in
      #if signed_in?
      #  #this flash doesn't work but seems like a good idea
      #  flash.now[:error] = "You are already created"
      #  redirect_to root_path
      #else
        store_location
        redirect_to signin_path, notice: "Please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
