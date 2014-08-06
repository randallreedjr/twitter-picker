class TwitterAPI
  def initialize
    @consumer_key = OAuth::Consumer.new(
                  ENV['TWITTER_API_KEY'],
                  ENV['TWITTER_API_SECRET'])
    @access_token = OAuth::Token.new(
                  ENV['TWITTER_ACCESS_TOKEN'],
                  ENV['TWITTER_ACCESS_TOKEN_SECRET'])
    @baseurl = "https://api.twitter.com"
    @path    = "/1.1/search/tweets.json"
  end

  def access_token
    @access_token
  end

  def hashtag_search(hashtag, start_time, end_time, since_id, max_id)
    
    if max_id > 0 && since_id > 0
      query   = URI.encode_www_form("q" => hashtag,
                                    "since_id" => since_id,
                                    "max_id" => max_id,
                                    "since" => start_time,
                                    "until" => end_time,
                                    "count" => 100)
    elsif since_id > 0
      query   = URI.encode_www_form("q" => hashtag,
                                    "since_id" => since_id,
                                    "since" => start_time,
                                    "until" => end_time,
                                    "count" => 100)
    elsif max_id > 0
      query   = URI.encode_www_form("q" => hashtag,
                                    "max_id" => max_id,
                                    "since" => start_time,
                                    "until" => end_time,
                                    "count" => 100)
    else
      query   = URI.encode_www_form("q" => hashtag,
                                    "since_id" => since_id,
                                    "since" => start_time,
                                    "until" => end_time,
                                    "count" => 100)
    end
    
    #query = URI.encode_www_form("q" => hashtag, "count" => 100, "page" => page)

    
    address = URI("#{@baseurl}#{@path}?#{query}")

    request = Net::HTTP::Get.new address.request_uri

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, @consumer_key, @access_token
    http.start
    response = http.request request
    if response.code == '200' then

      JSON.parse(response.body)
    else
      { "statuses" => [] }
    end
  end
end