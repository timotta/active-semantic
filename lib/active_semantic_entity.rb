class ActiveSemantic

  class Entity

    def initialize(data)
      @data = data
    end

    def uri
      return attributes['about'].first
    end
    
    def method_missing(method, *args)
      attribute_by_name(method.to_s)
    end
    
    protected
    
    def attribute_by_name(name)
      value = attributes[ name.to_s ]
      return [] if value.nil?
      value
    end
    
    def attributes
      return @attributes unless @attributes.nil?
      @attributes = {}
      @data.each do |key,value|
        @attributes[ key.split(':')[1] ] = prepare_attribute_value( value )
      end
      @attributes
    end
    
    private
    
    def prepare_attribute_value(value)
      return [value] unless value.is_a? Array
      if value.first.is_a?(Hash) and not value.first['rdf:resource'].nil?
        value = value.collect do |resource|
          LazyEntity.new( resource['rdf:resource'] )
        end
      end
      value
    end

  end

end

