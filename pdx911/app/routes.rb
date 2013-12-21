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
get '/dispatches' do
  jsonp_response query(
    'SELECT * FROM dispatches LIMIT $1 OFFSET $2',
    settings.max_results, 
    params[:offset].to_i
  )
end



# Return a list of dispatches for a given agency.
# Results are limited by the 'max_results' setting.
# 
# Params
# - callback  : the name of the JSONP callback function
# - offset    : the number of results by which the query is offset
# - agency_id : the ID of the agency by which dispatches are filtered
get '/dispatches/agency/:agency_id' do
  jsonp_response query(
    'SELECT * FROM dispatches WHERE agency_id = $3 LIMIT $1 OFFSET $2',
    settings.max_results,
    params[:offset].to_i,
    params[:agency_id].to_i
  )
end



# Return a list of dispatches for a given category.
# Results are limited by the 'max_results' setting.
# 
# Params
# - callback    : the name of the JSONP callback function
# - offset      : the number of results by which the query is offset
# - category_id : the ID of the category by which dispatches are filtered
get '/dispatches/category/:category_id' do
  jsonp_response query(
    'SELECT * FROM dispatches WHERE category_id = $3 LIMIT $1 OFFSET $2',
    settings.max_results,
    params[:offset].to_i,
    params[:category_id].to_i
  )
end



# Catchall route returns 404 status.
get "/*" do
  404
end
