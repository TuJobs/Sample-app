class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]

    unless @user.present?
      flash[:danger] = t ".not_search"
      redirect_to root_path
    end
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed

    unless @user.present?
      flash[:danger] = t ".not_destroy"
      redirect_to root_path
    end
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

end
