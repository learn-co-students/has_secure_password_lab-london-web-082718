class UsersController < ApplicationController

  before_action :require_login, only: :show


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)  # create has user_params within it - inputted from form
    if @user.valid?
      @user.save
      #  SESSIONS STUFF
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to new_user_path
    end
    # SAME AS
    # return redirect_to controller: 'users', action: 'new' unless @user.save
    # session[:user_id] = @user.id
    # redirect_to controller: 'welcome', action: 'home'
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end


end
