require File.join(File.dirname(__FILE__), "spec_helper")

describe SemanticEntity do
  
  describe 'when finding a TV Show with series.rdf' do
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
    it 'should have five seasons' do
      SemanticEntity.find(@uri).season.size.should == 5
    end
    
    describe 'and getting one season' do
      it 'should have an description' do
        SemanticEntity.find(@uri).season.first.description.first == 'Concentrated on the middle-section survivors and their fight for survival and rescue.'
      end
    end
    
  end
  
  
  
end
