class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate( params[:password] )
      # successful login
      session[:user_id] = user.id
      redirect_to '/dragdrop'
    else
      # bad credentials
      flash[:error] = "Invalid email and/or password"
      redirect_to login_path
    end

  end


  def destroy
    session[:user_id] = nil   # unset/remove session
    redirect_to root_path
  end

end
