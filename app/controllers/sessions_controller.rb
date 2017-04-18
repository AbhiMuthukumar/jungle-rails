class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # @user = User.find_by_email(params[:email])
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      flash[:notice] = nil
      session[:user_id] = @user.id
      redirect_to products_path
    else
      flash[:notice] = ["Incorrect Email ID or Password!"]
      render "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
