class UsersController < ApplicationController

  before_action :get_user,        only: [:show, :edit, :update]
  before_action :check_if_admin,  only: [:index]

  before_action :check_if_logged_in, except: [:new, :create]

  def get_user
    @user = User.find params["id"]
  end

  def new
    @user = User.new

  end

  def create

    # @user = User.create user_params

    @user = User.new(user_params)

    if params[:file].present?
      req = Cloudinary::Uploader.upload params[:file]
      @user.image = req['public_id']
    else
      @user.image = "https://robohash.org/#{ user_params[:name]}"
    end

    @user.save

    if @user.id.present?
      session[:user_id] = @user.id # perform login (set session)

      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    # @user = User.find params["id"]   # now in before_action
    redirect_to root_path unless @current_user == @user
  end

  def update
    # @user = User.find params["id"]   # now in before_action
    # redirect_to root_path unless @current_user == @user

    @user = @current_user # makes sure user can only edit their own profile

    if params[:file].present?
      req = Cloudinary::Uploader.upload params[:file]
      @user.image = req['public_id']
    end

    @user.update user_params
    redirect_to user_path( params["id"] )
  end

  def index
    @all_users = User.all
  end

  def show
    # catches URLS like /users/:id
    # @user = User.find params["id"]   # now in before_action
  end

  def destroy
    session[:user_id] = nil
    @user = @current_user.delete
    flash[:delete]= "User deleted successfully"
    redirect_to new_user_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :image, :password, :password_confirmation)
  end
end
