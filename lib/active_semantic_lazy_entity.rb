class ActiveSemantic
  
  class LazyEntity < Entity
    
    def initialize(uri)
      @uri = uri
    end
    
    def uri
      @uri
    end
    
    def method_missing(method, *args)
      load_data
      attribute_by_name(method.to_s)
    end
    
    private 
    
    def load_data
      return unless @data.nil?
      @data = ActiveSemantic.find_data_by_uri(@uri)
    end
  
  end

end

