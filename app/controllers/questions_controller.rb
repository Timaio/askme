class QuestionsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  
  before_action :set_question, only: %i[update show destroy edit hide]

  def create
    question = Question.create(question_params)
    
    redirect_to question_path(question)
  end

  def update
    @question.update(question_params)

    redirect_to question_path(@question)
  end

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  def hide
    @question.update(hidden: true)
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id, :hidden)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
