require File.join(File.dirname(__FILE__),'semantic_connector')

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

