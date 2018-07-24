class SolutionsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @solution = @question.solutions.build(solution_params)

    if @solution.save
      flash[:notice] = "Solution created"
    else
      flash[:alert] = @solution.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: questions_path)
  end
  
  def unfavorite
    # 在這裡寫程式碼 
  end

  def upvote
    # 在這裡寫程式碼
  end

  private

  def solution_params
    params.require(:solution).permit(:content)
  end

  
end
