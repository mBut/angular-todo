class AddUserRelationToTaskLists < ActiveRecord::Migration
  def change
    add_column :task_lists, :user_id, :integer
    add_column :tasks, :user_id, :integer
  end
end
