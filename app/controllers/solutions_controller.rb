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
end
