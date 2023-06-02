class SessionsController < ApplicationController
  def create
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
    if user
      session[:user_id] = user.id
      unless request.referer == cart_path
        redirect_to root_path, notice: "You have successfully logged in."
      else
        redirect_to root_path, flash: {}
      end
    else
      render 'new', alert: "There was something wrong with your login details."
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:cart)
    redirect_to root_path, notice: "You have successfully logged out."
  end
end