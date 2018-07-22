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

  def favorite
    @question = Question.find(params[:id])
    favorites = Favorite.where(question: @question, user: current_user)
    if favorites.exists?
      flash[:alert] = "已在收藏列表之中"
    else
      @question.favorites.create!(user: current_user)
      flash[:alert] = "收藏成功"
    end
    redirect_back(fallback_location: question_path(id: @question.id))  # 導回上一頁
  end

  def unfavorite
    @question = Question.find(params[:id])
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
    flash[:alert] = "取消收藏"
    redirect_back(fallback_location: question_path(id: @question.id))  # 導回上一頁
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvotes.create!(user: current_user)
    redirect_back(fallback_location: question_path(id: @question.id))
  end

  def unupvote
    @question = Question.find(params[:id])
    upvotes = Upvote.where(question: @question, user: current_user)
    upvotes.destroy_all
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
