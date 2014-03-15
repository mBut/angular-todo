json.array! @tasks do |task|
  json.id   task.id
  json.note task.note
  json.completed_flag task.completed_flag
end