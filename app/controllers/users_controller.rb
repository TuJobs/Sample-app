class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin!, only: :destroy
  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.select(:id, :email, :name).order(:id)
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t ".spam"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_update"
      redirect_to @user
    else
      flash[:danger] = t ".not_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_user"
      redirect_to users_url
    else
      flash[:danger] = t ".not_destroy"
      redirect_back users_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
      store_location
      flash[:danger] = t ".please"
      redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.is? @user
  end

  def verify_admin!
    redirect_to root_url unless current_user.is_admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    render file: "public/404.html", layout: false unless @user
  end
end
