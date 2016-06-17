class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      sign_in(user) #check application_controller
      redirect_to root_path, notice: "You are now signed in!"
    else
      flash[:alert] = "Wrong credentials!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "you have signed out"
  end
end
