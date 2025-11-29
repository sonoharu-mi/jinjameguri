json.array!(@events) do |event|
  json.id event.id
  json.event event.event
end