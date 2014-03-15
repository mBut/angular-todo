class Api::TasksController < ApplicationController

  def index
    @tasks = Task.where(task_list_id: params[:task_list_id])
  end

  def create
    task_list = TaskList.find(params[:task_list_id])
    @task = task_list.tasks.create!(new_task_params)
  end

  protected

  def new_task_params
    params.require(:task).permit(:note)
  end

end