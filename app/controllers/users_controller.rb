class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if (user.save)
      flash[:notice] = nil
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:notice] = user.errors.full_messages
      render '/users/new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
