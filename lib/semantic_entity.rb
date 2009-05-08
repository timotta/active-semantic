require File.join(File.dirname(__FILE__),'semantic_connector')

class SemanticEntity

  def initialize(data)
    @data = data
  end
  
  def uri
    return @data['rdf:about']
  end
  
  def method_missing(method, *args)
    value = value_by_attribute_name(method.to_s)
    return [] if value.nil?
    return [value] unless value.is_a? Array
    value
  end

  def self.find(uri)
    data = extract_describe SemanticConnector.describe(uri)
    return new( data )
  end
  
  private
  
  def value_by_attribute_name(name)
    @data.each do |key,value|
      if key.split(':')[1] == name.to_s
        return value
      end
    end
    nil
  end

  def self.extract_describe( data )
    data['rdf:RDF'].each do |key, value|
      return value unless key.index('xmlns')==0
    end
  end

end