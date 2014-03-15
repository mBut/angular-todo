json.array! @tasks do |task|
  json.id   task.id
  json.note task.note
  json.completed_flag task.completed_flag
  json.due_date task.due_date
  json.task_list_id task.task_list_id
end