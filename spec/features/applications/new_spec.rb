require "rails_helper"

RSpec.describe "new application page" do 
  it "has a form with fields for: name, full address, description" do

    visit "/pets"
    expect(page).to have_link "Start an Application"
    click_link "Start an Application"
    expect(current_path).to eq('/applications/new')

    fill_in "name", with: "Aidan"
    fill_in "street_address", with: "123 street"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in 'zip_code', with: 111111
    fill_in "description", with: "I like Dogs very much"

    click_button "Submit"

    expect(page).to have_content("Aidan")
  end

  it 'displays an error if required field is not completed' do
    visit '/applications/new'

    click_on 'Submit'
    
    expect(page).to have_content("Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Description can't be blank, Zip code can't be blank, and Zip code is not a number")
    expect(page).to have_button('Submit')
  end
end