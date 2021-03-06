configure :production, :development do
  
  set :database_connection, {
    host:     'localhost'                              ,
    dbname:   ENV['PDX911_DATABASE_NAME']              ,
    user:     ENV['PDX911_READONLY_DATABASE_USER']     ,
    password: ENV['PDX911_READONLY_DATABASE_PASSWORD'] ,
    sslmode:  ENV['PDX911_READONLY_DATABASE_SSL_MODE']
  }

  set :max_results, 100
        
end



configure :test do

  set :database_connection, {
    host:   'localhost'   ,
    dbname: 'pdx911_test' ,
    options: '--client-min-messages=warning'
  }

  set :max_results, 5
  
end



configure do
  
  set :protection, except: :json_csrf  # Prevent 403 on AJAX requests
  
  set :feed_uri, URI.parse('http://www.portlandonline.com/scripts/911incidents.cfm')
  
end