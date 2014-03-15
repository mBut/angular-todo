class Api::TasksController < ApplicationController

  TASKS_PER_PAGE = 20

  def index
    page = params[:page] || 1
    @tasks = Task.where(task_list_id: params[:task_list_id]).paginate(page: page, per_page: TASKS_PER_PAGE)
  end

  def create
    task_list = TaskList.find(params[:task_list_id])
    @task = task_list.tasks.create!(new_task_params)
  end

  def update
    task = Task.find(params[:id])
    head :ok if task.update_attributes(update_task_params)
  end

  def destroy
    head :ok if Task.find(params[:id]).destroy
  end

  protected

  def new_task_params
    params.require(:task).permit(:note)
  end

  def update_task_params
    params.require(:task).permit(:note, :due_date, :completed_flag, :task_list_id)
  end

end