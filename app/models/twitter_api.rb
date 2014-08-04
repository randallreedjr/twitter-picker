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

  def hashtag_search(hashtag)
    query   = URI.encode_www_form("q" => hashtag)
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