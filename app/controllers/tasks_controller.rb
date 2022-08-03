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
   end
   
   
   def create
      @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
    
    def update
    end
   end
   
  def destroy
    
  end

  private
  
   def set_user
      @user = User.find(params[:user_id])
   end
   
   def task_params
     params.require(:task).permit(:name, :description)
   end
   
end