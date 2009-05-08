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
      SemanticEntity.find(@uri).nome.first.should == 'SporTV'
    end
    it 'should have a adress' do
      SemanticEntity.find(@uri).endereco.should == ["barbecue.dev.globoi.com", "sportv.globo.com", "localhost", "sportv.dev.globoi.com", "barbecue.qa02.globoi.com", "10.2.10.112", "barbecue.wm.globoi.com", "barbecue.qa01.globoi.com", "localhost:3030"]
    end
  end
  
end
