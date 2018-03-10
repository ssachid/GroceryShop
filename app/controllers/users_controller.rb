class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :require_user, only: [:edit,:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}!"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :username, :email, :password, :password_confirmation)
  end
end
