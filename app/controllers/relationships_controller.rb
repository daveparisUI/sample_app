class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  #11.5.2: removing respond_to, replacing w/respond_with
  respond_to :html, :js #Here you specify the formats that the Responder should handle.

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    #redirect_to @user

    #11.5.2: cont'd; The options here are those that would be passed to render or redirect_to in your controller, but they are only included for success scenarios. For GET actions these would be the render calls, for other actions this would be the options for redirect.
      #For a given controller action, respond_with generates an appropriate response based on the mime-type requested by the client.
    respond_with @user
    #11.38: responding to AJAX requests
    #respond_to do |format|
    #  format.html { redirect_to @user }
    #  format.js
    #end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    #redirect_to @user


    #11.5.2: cont'd
    respond_with @user
    #11.38: responding to AJAX requests
    #respond_to do |format|
    #    format.html { redirect_to @user }
    #    format.js
    #  end
  end
end