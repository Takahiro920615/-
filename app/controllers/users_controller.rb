class UsersController < ApplicationController
  before_action :set_user, only: %i( show edit update destroy)
 
  def new
    @user = User.new
  end
   
   def index
     @users = User.paginate(page: params[:page])
   end

  
  def show
    @user = User.find(params[:id])
  end


  
  def edit
   
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user= User.find(params[:id])
    end
end
