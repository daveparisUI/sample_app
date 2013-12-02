class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        #Listing 9.20: redirects to URI if exists otherwise to default which is
        #from sessions controller create
        #like session[:return_to]
        redirect_back_or user
        #redirect_to user #- this pg said if i changed it it would work http://stackoverflow.com/questions/13793396/ruby-on-rails-tutorial-9-2-3-friendly-forwarding-error
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
    end

  def destroy
    sign_out
    redirect_to root_path
  end
end