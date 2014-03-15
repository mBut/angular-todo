json.array! @tasks do |task|
  json.id   task.id
  json.note task.note
end