class Api::TasksController < ApplicationController

  def index
    @tasks = Task.where(task_list_id: params[:task_list_id])
  end

  def create
    task_list = TaskList.find(params[:task_list_id])
    @task = task_list.tasks.create!(new_task_params)
  end

  def update
    task = Task.find(params[:id])
    head :ok if task.update_attributes(update_task_params)
  end

  protected

  def new_task_params
    params.require(:task).permit(:note)
  end

  def update_task_params
    params.require(:task).permit(:note, :due_date, :completed_flag)
  end

end