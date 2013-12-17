class MicropostsController < ApplicationController
  #10.28: created controller, adding authentication to it
  before_filter :signed_in_user, only: [:create, :destroy]
  #10.49: destroy action
  before_filter :correct_user, only: :destroy

  def create
    #10.30: mp create action
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      #10.45: empty instance array var to prevent empty posts from breaking
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    #10.49: cont'd; destroy action
    @micropost.destroy
    redirect_to root_url
  end

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
