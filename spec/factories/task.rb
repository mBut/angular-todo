FactoryGirl.define do
  factory :task do
    task_list
    note "Default task"
    completed_flag false
    due_date Date.today
  end
end