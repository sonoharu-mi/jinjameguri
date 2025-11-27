json.array!(@calendars) do |calendar|
  json.id calendar.id
  json.event calendar.event
end