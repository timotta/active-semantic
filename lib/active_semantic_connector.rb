require 'httparty'

class ActiveSemantic
  class Connector
    
    include HTTParty
  
    base_uri 'http://localhost:2020'
    default_params :output => 'xml'
    format :xml
    
    def self.describe(uri)
      query = "DESCRIBE <#{uri}>"
      get('/sparql', :query => {:query => query})
    end
    
  end
end