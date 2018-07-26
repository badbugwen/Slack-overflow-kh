class SolutionsController < ApplicationController

    def upvote
      @upvote = Solution.find(params[:id])
      @solution.upvotes.create!(user: current_user)
      redirect_back(fallback_location: question_path(id: @question.id))  # 導回上一頁
      render :questions =>"show"
    end

    def unupvote
      @upvote = Solution.find(params[:id])
      upvotes = Upvote.where(solution: @solution, user: current_user)
      upvotes.destroy_all
      redirect_back(fallback_location: question_path(id: @question.id))
      render :questions =>"show"
    end


  def create
    @question = Question.find(params[:question_id])
    @solution = @question.solutions.build(solution_params)
    @solution.user = current_user

    if @solution.save
      flash[:notice] = "Solution created"
    else
      flash[:alert] = @solution.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: questions_path)
  end


  private

  def solution_params
    params.require(:solution).permit(:content)
  end

end
