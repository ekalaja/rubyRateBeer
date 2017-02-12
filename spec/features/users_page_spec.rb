require 'rails_helper'

include Helpers

describe "User" do
  #before :each do    
    #user = FactoryGirl.create :user
  #end
  
  describe "who has signed up" do
    let!(:user) { FactoryGirl.create :user }

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "can delete one's only rating" do
      
      sign_in(username:"Pekka", password:"Foobar1")
      create_beer_with_rating(user, 10)
      create_rated_beer_with_name(user, 12, "hapan")
      
      visit user_path (user)
      
      expect{
        #ei toimi alla kommentoiduilla
        #within(".10") do
        #click_("delete")
        #end
        page.first(:link, "delete").click
      }.to change{Rating.count}.from(2).to(1)
    end
  
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end

describe "User's page" do
  #before :each do
    #user = FactoryGirl.create :user
    #user2 = FactoryGirl.create :user2
    #beer = FactoryGirl.create(:beer, name: "bestBeer")
    #r = FactoryGirl.create(:rating, score:10,  beer:beer, user: user1)
    #r = FactoryGirl.create(:rating, score:10,  beer:beer, user: user2)


    let!(:user) { FactoryGirl.create :user }
    let!(:user2) { FactoryGirl.create :user2 }
    #let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }

  #end

  it "lists only the ratings of the User" do
    create_beer_with_rating(user, 10)
    create_rated_beer_with_name(user2, 13, "Karjala")
    visit user_path (user)
    expect(page).to have_content "Has made 1 rating"
    expect(page).to have_no_content "Karjala"
      
  end

  it "has favorite style and brewery announced if ratings given" do
    create_beers_with_ratings(user, 10, 12)
    create_rated_beer_with_name(user, 12, "Green's IPA")
    
    visit user_path (user)
    expect(page).to have_content "Favorite style is IPA"
    expect(page).to have_content "brewery is Old Brew"
  end

end
