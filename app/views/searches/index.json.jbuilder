json.array!(@searches) do |search|
  json.extract! search, :id, :hashtag
  json.url search_url(search, format: :json)
end
