class UsersController < ApplicationController

  def index
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @question_count = @user.questions.size
  end

  private

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
