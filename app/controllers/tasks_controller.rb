class TasksController < ApplicationController
   before_action :set_user

   
  
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
     @task_id = params[:id]
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
    @task=Task.find(params[:id])
    @task.name = params[:name]
    @task.description = params[:description]
    @task.save
     redirect_to user_task_url @user,@task
    end
   

  private
  
   def set_user
      @user = User.find(params[:user_id])
   end
   
   def task_params
     params.require(:task).permit(:name, :description)
   end
end