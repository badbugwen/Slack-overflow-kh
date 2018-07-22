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

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
