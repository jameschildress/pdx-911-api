# Proxy for the Portland 911 RSS feed.
# 
# Params
# - callback : the name of the JSONP callback function
get '/feed' do
  jsonp_response Net::HTTP.get(settings.feed_uri.host, settings.feed_uri.path)
end



# Return all agencies.
# 
# Params
# - callback : the name of the JSONP callback function
get '/agencies' do
  jsonp_response query('SELECT * FROM agencies')
end



# Return all categories.
# 
# Params
# - callback : the name of the JSONP callback function
get '/categories' do
  jsonp_response query('SELECT * FROM categories')
end



# Return a list of dispatches.
# Results are limited by the 'max_results' setting.
# 
# Params
# - callback : the name of the JSONP callback function
# - offset   : the number of dispatches by which the results are offset
# - agency   : only return dispatches with this agency ID
# - category : only return dispatches with this category ID
# - before   : only return dispatches that occurred before this time (in seconds since the Unix Epoch) 
# - after    : only return dispatches that occurred on or after this time (in seconds since the Unix Epoch) 
get '/dispatches' do
  
  where = [];
  where << "agency_id = #{params[:agency].to_i}"       if params[:agency]
  where << "category_id = #{params[:category].to_i}"   if params[:category]
  where << "date < '#{Time.at(params[:before].to_i)}'" if params[:before]
  where << "date >= '#{Time.at(params[:after].to_i)}'" if params[:after]
  where = where.join " AND "
  where = "WHERE " + where unless where.empty?
  
  jsonp_response query(
    "SELECT * FROM dispatches #{where} ORDER BY date DESC LIMIT $1 OFFSET $2",
    settings.max_results, 
    params[:offset].to_i
  )
end



# Catchall route returns 404 status.
get "/*" do
  404
end
