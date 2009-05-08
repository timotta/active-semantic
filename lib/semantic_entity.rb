require File.join(File.dirname(__FILE__),'semantic_connector')

class SemanticEntity

  def initialize(data)
    @data = data
  end
  
  def uri
    return @data['rdf:about']
  end
  
  def method_missing(method, *args)
    @data.each do |key,value|
      return value if key.split(':')[1] == method.to_s
    end
  end

  def self.find(uri)
    data = extract_describe SemanticConnector.describe(uri)
    return new( data )
  end

  def self.extract_describe( data )
    data['rdf:RDF'].each do |key, value|
      return value unless key.index('xmlns')==0
    end
  end

end