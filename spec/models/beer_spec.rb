require 'rails_helper'

RSpec.describe Beer, type: :model do

    
      describe " with a proper brewery_id" do
        let(:brewery){ Brewery.create name:"Paraspanimo", year:1999 }
        
        it "is not saved without a name" do
          beer = Beer.create style:"Lager", brewery_id: brewery.id
          expect(beer).not_to be_valid
          expect(Beer.count).to eq(0)
        end

        it "is not saved with empty style" do
          beer = Beer.create name:"hieno-olut", style:"", brewery_id: brewery.id
          expect(beer).not_to be_valid
          expect(Beer.count).to eq(0)
        end
        
        it "is not saved without a style" do
          beer = Beer.create name:"",  brewery_id: brewery.id
          expect(beer).not_to be_valid
          expect(Beer.count).to eq(0)
        end    

        it "is saved when given name and style" do
          beer = Beer.create name:"parasolut", style: "Lager", brewery_id: brewery.id
          expect(beer).to be_valid
          expect(Beer.count).to eq(1)
        end
      end
end
