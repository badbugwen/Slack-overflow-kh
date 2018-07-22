class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = "Question was successfully created"
      redirect_to questions_url
    else
      flash.now[:alert] = "Question was failed to create"
      render :new
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @solutions =@question.solutions.order(upvotes_count: :desc)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
    flash[:alert] = "question was deleted"
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def authenticate_user
    unless current_user.signed_in?
     flash[:alert] = "Not allow!"
     redirect_to questions_path
    end
  end

end
