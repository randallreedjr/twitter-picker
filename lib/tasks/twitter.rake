namespace :twitter do
  desc "Calls Twitter API to load new tweets for all campaigns"
  task refresh_tweets: :environment do
    t = Time.now
    Campaign.where("start_time < ? AND end_time > ?", t, t + 600).each do |c|
      c.find_tweets
    end
  end

end
