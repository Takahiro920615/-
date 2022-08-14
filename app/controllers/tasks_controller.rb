class TasksController < ApplicationController
   before_action :set_user
   before_action :set_task, only: %i(show edit update destroy)
   
  
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
       if @task.update_attributes(task_params)
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