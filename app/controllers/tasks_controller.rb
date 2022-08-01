class TasksController < ApplicationController
   before_action :set_user

   
  
   def index
    @tasks = @user.tasks
    @task = Task.all
  
   end
   
   def show

   end
   
  def destroy
    
  end

  private
  
   def set_user
      @user = User.find(params[:user_id])
     
   end
   
end