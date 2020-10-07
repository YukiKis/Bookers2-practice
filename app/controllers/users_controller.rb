class UsersController < ApplicationController
  before_action :setup, only: [:index, :show]
  before_action :authenticate_user!

  def setup
    @book_new = Book.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user == current_user
      if user.update(user_params)
        redirect_to user
      else
        render "edit"
      end
    end
  end

  def followers
    user = User.find(params[:id])
    @followers = user.followers
  end

  def following
    user = User.find(params[:id])
    @following = user.following
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
