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
      create_hashtags
      flash[:notice] = "Question was successfully created"
      redirect_to questions_url
    else
      flash.now[:alert] = "Question was failed to create"
      render :new
    end
  end

  def hashtags
    if params[:search]
      tag = Tag.find_by(name: params[:search])
        if tag
          redirect_to "/questions/hashtag/#{tag.name}"
          params[:name] = params[:search]
        else
          flash[:alert] = "Sorry! #{params[:search]} was not found. Here are all hashtags"
          redirect_to tag_all_path
       end  
    else  
      @tag = Tag.find_by(name: params[:name])
      @questions = @tag.questions
    end  
  end

  def tag_all
    @tags = Tag.all
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

  def create_hashtags
    hashtags = @question.content.scan(/#\w+/)
    flash[:alert] = "There are only 3 hashtags allowed in a question" if hashtags.uniq.size > 3
    hashtags.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      if tag.valid?
        @question.tags << tag if @question.tags.size < 3
      else
        tag.destroy
        flash[:alert] = "hashtag that over 10 charaters is NOT allowed"
      end  
    end  
  end

end
