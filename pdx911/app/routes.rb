# Proxy for the Portland 911 RSS feed.
get '/feed' do
  rss = Net::HTTP.get(settings.feed_uri.host, settings.feed_uri.path)
  jsonp_response rss, params[:callback]
end