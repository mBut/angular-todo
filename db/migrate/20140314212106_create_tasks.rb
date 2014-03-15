class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :task_list
      t.string :note
      t.boolean :completed_flag, default: false
      t.timestamp :due_date 
    end
  end
end
