require File.join(File.dirname(__FILE__),'semantic_connector')

class SemanticEntity

  def initialize(data)
    @data = data
  end
  
  def uri
    return attributes['about'].first
  end
  
  def method_missing(method, *args)
    attribute_by_name(method.to_s)
  end

  def self.find(uri)
    return new( find_data_by_uri(uri) )
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
  
  def self.extract_describe( data )
    data['rdf:RDF'].each do |key, value|
      return value unless key.index('xmlns')==0
    end
  end
  
  def self.find_data_by_uri(uri)
    extract_describe SemanticConnector.describe(uri)
  end
  
  private
  
  def prepare_attribute_value(value)
    return [value] unless value.is_a? Array
    if value.first.is_a?(Hash) and not value.first['rdf:resource'].nil?
      value = value.collect do |resource|
        SemanticLazyEntity.new( resource['rdf:resource'] )
      end
    end
    value
  end

end

class SemanticLazyEntity < SemanticEntity
  
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
    @data = SemanticEntity.find_data_by_uri(@uri)
  end

end