require File.join(File.dirname(__FILE__),'active_semantic_connector')
require File.join(File.dirname(__FILE__),'active_semantic_entity')
require File.join(File.dirname(__FILE__),'active_semantic_lazy_entity')

class ActiveSemantic

  def self.find(uri)
    return Entity.new( find_data_by_uri(uri) )
  end
  
  protected
  
  def self.extract_describe( data )
    data['rdf:RDF'].each do |key, value|
      return value unless key.index('xmlns')==0
    end
  end
  
  def self.find_data_by_uri(uri)
    extract_describe Connector.describe(uri)
  end
  
end