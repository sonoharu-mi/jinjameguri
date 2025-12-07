json.array!(@events) do |event|
  json.id event.id
  json.title "#{event.prefecture}#{event.city}：#{event.event}"
  json.start event.start_date
  json.end event.end_date
  json.editable event.editable
end