require File.join(File.dirname(__FILE__), "spec_helper")

describe SemanticEntity do
  
  describe 'when finding an entity' do
    before :each do
      @uri = 'http://www.semanticweb.org/ontologies/series/Lost'
    end
    it 'should returns an SemanticEntity' do
      SemanticEntity.find(@uri).class.should be_equal(SemanticEntity)
    end
    it 'should have the uri' do
      SemanticEntity.find(@uri).uri.should == @uri
    end
    it 'should have a name' do
      SemanticEntity.find(@uri).name.first.should == 'Lost'
    end
    it 'should have a adress' do
      SemanticEntity.find(@uri).site.should == ["http://lostpedia.wikia.com/wiki/Main_Page", "http://www.lostbrasil.com/"]
    end
    it 'should be an empty array when asking for a property that doesnt exists' do
      SemanticEntity.find(@uri).jurubeba.should == []
    end
  end
  
end
