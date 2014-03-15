class Api::TaskListsController < ApplicationController

  # All JSON responses generates with jBuilder library help
  # what gives possibility to create more flexible JSON objects

  def index
    @task_lists = TaskList.all
  end

  def create
    @task_list = TaskList.create!(new_list_params)
  end

  def tasks
    @tasks = TaskList.find(params[:task_list_id]).tasks
  end

  protected

  def new_list_params
    params.require(:task_list).permit(:name)
  end

end