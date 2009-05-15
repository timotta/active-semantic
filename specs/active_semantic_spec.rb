require File.join(File.dirname(__FILE__), "spec_helper")

describe ActiveSemantic do
  
  describe 'when finding a TV Show with series.rdf' do
    before :each do
      @uri = 'http://www.semanticweb.org/ontologies/series/Lost'
    end
    it 'should returns an SemanticEntity' do
      ActiveSemantic.find(@uri).class.should be_equal(ActiveSemantic::Entity)
    end
    it 'should have the uri' do
      ActiveSemantic.find(@uri).uri.should == @uri
    end
    it 'should have a name' do
      ActiveSemantic.find(@uri).name.first.should == 'Lost'
    end
    it 'should have a adress' do
      ActiveSemantic.find(@uri).site.should == ["http://lostpedia.wikia.com/wiki/Main_Page", "http://www.lostbrasil.com/"]
    end
    it 'should be an empty array when asking for a property that doesnt exists' do
      ActiveSemantic.find(@uri).jurubeba.should == []
    end
    it 'should have five seasons' do
      ActiveSemantic.find(@uri).season.size.should == 5
    end
    
    describe 'and getting one season' do
      it 'should be an SemanticLazyEntity' do
        ActiveSemantic.find(@uri).season.first.class.should be_equal(ActiveSemantic::LazyEntity)
      end
      it 'should have an description' do
        ActiveSemantic.find(@uri).season.first.description.first == 'Concentrated on the middle-section survivors and their fight for survival and rescue.'
      end
    end
    
    describe 'and getting other season' do
      it 'should have an description' do
        ActiveSemantic.find(@uri).season[1].description.first == 'Focused on the Hatch.'
      end
    end
    
  end
  
  
  
end
