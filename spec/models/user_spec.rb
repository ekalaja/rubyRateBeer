require 'rails_helper'

RSpec.describe User, type: :model do

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a short password" do
    user = User.create username:"Pekka", password:"Sa1", password_confirmation:"Sa1"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password containing only letters" do
    user = User.create username:"Pekka", password:"Salainen", password_confirmation:"Salainen"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

      it "is saved" do
       expect(user).to be_valid
       expect(User.count).to eq(1)
      end
  end


  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "when one rated beer is the style of the beer" do
      beer = create_beer_with_rating(user, 10)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest average if several rated" do
      beer = create_beers_with_ratings(user, 12,13,16)
      beer2 = create_beer_with_rating(user, 15)
      expect(user.favorite_style).to eq(beer2.style)
    end
  end

  describe "favorite_brewery" do
    let(:user){ FactoryGirl.create(:user) }
    
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "is the one rated when only one rating" do
      beer = create_beer_with_rating(user, 12)
      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end

    it "is the one with highest average if several rated" do
      beer = create_beers_with_ratings(user, 12,13,16)
      beer2 = create_beer_with_rating(user, 15)
      expect(user.favorite_brewery).to eq(beer2.brewery.name)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      
      expect(user.favorite_beer).to eq(best)
    end
  end

end # describe User

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating user, score
  end
end

def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  r = FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end