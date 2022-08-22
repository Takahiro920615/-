class TasksController < ApplicationController
   before_action :set_user
   before_action :set_task, only: %i(show edit update destroy)
   before_action :logged_in_user, only: %i(edit index new show)
   
   
  
   def index
    @tasks = @user.tasks.order(created_at: :desc)
   
   end
   
   def show
    @task = Task.find(params[:id])
   end
   
   def new
    @task = Task.new
   end
   
   def edit
     @task = Task.find(params[:id])
   end
   
   
   def create
      @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_task_path @user, @task
    else
      render :new
    end
   end
    
  def update
      @task = Task.find(params[:user_id])
      @task.name = params[:name]
      @task.description = params[:description]
      
       if @task.save
          flash[:success] = "タスクを更新しました。"
          redirect_to user_task_url(@user, @task)
    　 else
          render :edit
       end
  end
    
    def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path @user
    end
   

  private
  
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
  
   def set_user
      @user = User.find(params[:user_id])
   end
   
   def task_params
     params.require(:task).permit(:name, :description)
   end
   
   def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url @user
      end
   end
   
 
end