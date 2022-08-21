class QuestionsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  
  before_action :set_question, only: %i[update show destroy edit toggle_visibility]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
     
    if @question.save
      redirect_to question_path(@question), notice: "New question created!"
    else
      flash.now[:alert] = "Fields filled out incorrectly."

      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question), notice: "Question updated!"
    else
      flash.now[:alert] = "Fields filled out incorrectly."

      render :edit
    end
  end

  def index
    @questions = Question.all
    @question = Question.new
  end

  def show
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question deleted!"
  end

  def toggle_visibility
    @question.update(hidden: !@question.hidden?)
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id, :hidden)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
