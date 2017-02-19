require 'rails_helper'

describe "Places" do

  it "if zero places found, notification is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("vantaa").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'vantaa')
    click_button "Search"

    expect(page).to have_content "No locations in vantaa"
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several places returned, they are all shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kotka").and_return(
        [ Place.new( name:"Seurahuone", id:1), Place.new( name:"Pub Jaakko", id:2)]
    )
    visit places_path
    fill_in('city', with: 'kotka')
    click_button "Search"
    expect(page).to have_content "Seurahuone"
    expect(page).to have_content "Pub Jaakko"
  end

end
