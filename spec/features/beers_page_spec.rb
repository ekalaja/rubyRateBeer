require 'rails_helper'
include Helpers

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user}
    
    it "created with a non empty name is added to the system" do
        sign_in(username:'Pekka', password:'Foobar1')
        visit new_beer_path
        fill_in('beer_name', with:'hyvaOlut')
        expect{
        click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "created without a name doesn't save" do
        sign_in(username:'Pekka', password:'Foobar1')
        visit new_beer_path
        fill_in('beer_name', with:'')
        expect{
        click_button('Create Beer')
        }.to change{Beer.count}.by(0)
        expect(page).to have_content 'Name is too short'
    end
    
end