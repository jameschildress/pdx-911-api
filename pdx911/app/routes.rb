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
# - offset   : the number of results by which the query is offset
# - agency   : the ID of the agency by which dispatches are filtered
# - category : the ID of the category by which dispatches are filtered
# - date     : TODO
get '/dispatches' do
  
  where = [];
  where << "agency_id = #{params[:agency].to_i}" if params[:agency]
  where << "category_id = #{params[:category].to_i}" if params[:category]
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
