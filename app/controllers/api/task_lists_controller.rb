class Api::TaskListsController < ApplicationController

  # All JSON responses generates with jBuilder library help
  # what gives possibility to create more flexible JSON objects

  def index
    @task_lists = current_user.task_lists.all
  end

  def create
    @task_list = current_user.task_lists.create!(new_list_params)
  end

  def tasks
    @tasks = current_user.task_lists.find(params[:task_list_id]).tasks
  end

  protected

  def new_list_params
    params.require(:task_list).permit(:name)
  end

end