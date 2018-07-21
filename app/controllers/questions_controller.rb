class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    # 這邊 create 的時候沒寫入 user
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
end
