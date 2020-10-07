class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    @user.reload
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    @user.reload
  end

end
