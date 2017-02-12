FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Jaska"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    user
    beer
    score 10
  end

  factory :rating2, class: Rating do
    user2
    beer2
    score 20
  end


  factory :brewery do
    name "ano_brew1"
    year 1900
  end

  factory :brewery2, class: Brewery do
    name "ano_brew2"
    year 1902
  end

  factory :beer do
    name "ano_beer"
    brewery
    style "Lager"
  end

  factory :beer2, class: Beer do
    name "ano_beer2"
    style "IPA"
  end  
end
