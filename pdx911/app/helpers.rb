helpers do


    
    # Return an array of the results of a parameterized SQL query.
    def query sql, *params
      db = PG::Connection.open(settings.database_connection)
      result = db.exec_params(sql, params)
      db.close
      result.to_a
    end
    
    
    
    # Return a valid Rack response object for a JSON or JSONP request.
    def jsonp_response content
      content_type :json
      json = content.to_json
      params[:callback] ? "#{params[:callback]}(#{json})" : json
    end
    
    
    
end