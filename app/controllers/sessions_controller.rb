class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have succesfully logged in"
      redirect_to products_path
    else
      flash[:danger] = "Email or Password invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out. Thank you for shopping. See you soon!"
    redirect_to root_path
  end

end
