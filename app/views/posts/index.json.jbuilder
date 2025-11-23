json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post.id
      json.user do
        json.name post.user.name
        json.image url_for(post.user.profile_image)
      end
      json.image url_for(post.image)
      json.shirine_name post.shirine_name
      json.body post.body
      json.address post.address
      json.parking post.parking
      json.shirine_stamp post.shirine_stamp
      json.seasonal_stamp post.seasonal_stamp
      json.latitude post.latitude
      json.longitude post.longitude
    end
  end
end