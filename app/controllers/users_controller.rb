class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :favorite]
  
  def index
  end
  
  def edit
    unless @user == current_user
      flash[:alert] = "Not allow"
      redirect_back(fallback_location: root_path)  
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end    
  end
  
  def favorite
    if @user != current_user
      flash[:alert] = "你不能觀看其他使用者的收藏"
      redirect_to root_path
    else
      @favorited_questions = @user.favorited_questions
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(
      :name,
      :intro,
      :company,
      :job_title,
      :website,
      :twitter,
      :github)
  end
  
end
