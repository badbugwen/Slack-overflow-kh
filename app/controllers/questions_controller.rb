class QuestionsController < ApplicationController

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(10)
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

  def hashtags
    @tag = Tag.find_by(name: params[:name])
    @questions = @tag.questions
  end

  def show
    @question = Question.find_by(id: params[:id])
    @solutions = @question.solutions.order(created_at: :asc)
    @solution = Solution.new
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
    flash[:alert] = "Question was deleted"
  end

  def favorite
    @question = Question.find(params[:id])
    favorites = Favorite.where(question: @question, user: current_user)
    if favorites.exists?
      flash[:alert] = "Already in your favorites list"
    else
      @question.favorites.create!(user: current_user)
      flash[:notice] = "Question was favorited successfully"
    end
    redirect_back(fallback_location: question_path(id: @question.id))  # 導回上一頁
  end

  def unfavorite
    @question = Question.find(params[:id])
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
    flash[:alert] = "Question was removed from your favorites list successfully"
    redirect_back(fallback_location: question_path(id: @question.id))  # 導回上一頁
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvotes.create!(user: current_user)
    flash[:notice] = "You upvote the question successfully"
    redirect_back(fallback_location: question_path(id: @question.id))
  end

  def unupvote
    @question = Question.find(params[:id])
    upvotes = Upvote.where(question: @question, user: current_user)
    upvotes.destroy_all
    flash[:alert] = "Your upvote was recalled successfully"
    redirect_back(fallback_location: question_path(id: @question.id))
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
