require 'rails_helper'

include Helpers
describe "Ratings" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  #vaihtoehtoinen tapa ennen kaikkia metodeja?
  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end


  it "when given, is registered to the beer and user who is signed in" do
    
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

end

describe " page" do
  let!(:user) { FactoryGirl.create :user }
  #let!(:rating) { FactoryGirl.create :rating, user_id: :user, beer_id: :beer}
  
    it "has number of ratings given 1 when one rating given" do
        beer = create_beer_with_rating(user, 10)
        visit ratings_path
        expect(page).to have_content ("Number of ratings 1")
    end

    it "has number of ratings given 0 when no ratings given" do
        visit ratings_path
        expect(page).to have_content ("Number of ratings 0")
    end
    #Mistä löytää create_beer_with_rating metodin ja miksi ei saa vaihdettua nimeä?
    it "contains the rating given" do
        create_beer_with_rating(user, 33) 
        visit ratings_path
        expect(page).to have_content ("33 Pekka")
    end
end
