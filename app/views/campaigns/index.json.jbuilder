json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :hashtag, :start_time, :end_time
  json.url campaign_url(campaign, format: :json)
end
