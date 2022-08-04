class TasksController < ApplicationController
   before_action :set_user

   
  
   def index
    @tasks = @user.tasks.order(created_at: :desc)
   end
   
   def show
    @task = Task.find(params[:id])
   end
   
   def new
     @task = Task.find(params[:id])
   end
   
   def edit
     @task = Task.all
   end
   
   
   def create
      @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
   end
    
    def update
    
     if @task.update_attributes(task_params)
         flash[:success]= "タスクの詳細を更新しました。"
         redirect_to user_task_url(@task,@task)
     else
         render :edit
     end
    end
   

  private
  
   def set_user
      @user = User.find(params[:user_id])
   end
   
   def task_params
     params.require(:task).permit(:name, :description)
   end
end