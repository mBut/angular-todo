json.array! @task_lists do |task_list|
  json.id   task_list.id
  json.name task_list.name
end