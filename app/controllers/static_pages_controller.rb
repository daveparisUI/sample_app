class StaticPagesController < ApplicationController
  def home
    if signed_in?
      #10.34: adding mp instance var - i would have never thought to do this
      @micropost = current_user.microposts.build if signed_in?
      #10.41: feed instance var
        @feed_items = current_user.feed.paginate(page: params[:page])
    end

  end

  def help
  end

  def about
    
  end

  def contact

  end
end
