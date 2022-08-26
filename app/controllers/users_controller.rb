class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy show]
  before_action :authorize_user, only: %i[edit update destroy]

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

  def show
    @questions = @user.questions.order("created_at DESC")
    @questioner_questions = @user.questioner_questions.order("created_at DESC")
    @question = Question.new(user: @user)
  end

  private 

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation, :header_color)
  end

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def authorize_user
    redirect_with_alert unless current_user == @user
  end
end
