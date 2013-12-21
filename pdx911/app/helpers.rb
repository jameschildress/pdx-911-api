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
      json = content.to_json
      json = params[:callback] ? "#{params[:callback]}(#{json})" : json
      [200, { "Content-Type" => "application/json" }, [json]]
    end
    
    
    
end