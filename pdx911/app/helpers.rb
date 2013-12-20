helpers do



    def query sql, *params
      db = PG::Connection.open(settings.database_connection)
      result = db.exec_params(sql, params)
      db.close
      result.to_a
    end
    
    
    
    def jsonp_response content, callback
      [
        200,
        { "Content-Type" => "application/json" },
        ["#{callback}(#{content.to_json})"]
      ]
    end
    
    
    
end