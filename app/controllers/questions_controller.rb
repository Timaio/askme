class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit toggle_visibility]
  before_action :set_question_for_current_user, only: %i[update destroy edit toggle_visibility]

  def new
    @user = User.find_by(nickname: params[:user_nickname])
    @question = Question.new(user: @user)
  end

  def create
    question_params = params.require(:question).permit(:body, :user_id, :hidden)
    @question = Question.new(question_params)
    @question.author = current_user
     
    if @question.save
      redirect_to user_path(@question.user.nickname), notice: "New question created!"
    else
      flash.now[:alert] = "Fields filled out incorrectly."

      render :new
    end
  end

  def edit
  end

  def update
    question_params = params.require(:question).permit(:body, :answer, :hidden)

    if @question.update(question_params)
      redirect_to user_path(@question.user.nickname), notice: "Question updated!"
    else
      flash.now[:alert] = "Fields filled out incorrectly."

      render :edit
    end
  end

  def index
    @questions = Question.order("created_at DESC").first(10)
    @users = User.order("created_at DESC").first(10)
    @hashtags = Hashtag.only_used
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @user = @question.user
    @question.destroy
    
    redirect_to user_path(@user.nickname), notice: "Question deleted!"
  end

  def toggle_visibility
    @question.update(hidden: !@question.hidden?)
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
