module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer, name: "bestBeer", style:"Lager")
    r = FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
    beer
  end
  def create_rated_beer_with_name(user, score, beer_name)
      brewery = FactoryGirl.create(:brewery, name: "Old Brew", year:1999)
      beer = FactoryGirl.create(:beer, name: beer_name, style:"IPA", brewery: brewery)
      r = FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  end
  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
        create_beer_with_rating user, score
    end
  end

end
