require File.join(File.dirname(__FILE__), "spec_helper")

describe SemanticEntity do
  
  describe 'when finding an entity' do
    before :each do
      @uri = 'http://semantica.globo.com/webmedia/catalogo/SporTV'
    end
    it 'should returns an SemanticEntity' do
      SemanticEntity.find(@uri).class.should be_equal(SemanticEntity)
    end
    it 'should have the uri' do
      SemanticEntity.find(@uri).uri.should == @uri
    end
    it 'should have a name' do
      SemanticEntity.find(@uri).nome.should == 'SporTV'
    end
  end
  
end

