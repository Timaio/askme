class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      
      redirect_to root_path, notice: "Sign up is successful!"
    else
      flash.now[:alert] = "Form fields filled out incorrectly."
      
      render :new
    end    
  end

  def edit     
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile updated!"
    else
      flash.now[:alert] = "Form fields filled out incorrectly."
      
      render :edit
    end  
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: "Account deleted"
  end

  private 

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation, :header_color)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
