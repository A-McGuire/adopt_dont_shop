require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve the adoption each individual pet for that application' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    
    PetApplication.create!(pet: pet1, application: application)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_button("Approve")
    click_button("Approve")
    expect(page).to have_content("Application Status: Approved")
    expect(page).to have_content("Application Status: #{application.status}")
  end

  it 'does not have a button to approve an adoption that has already been approved, instead I see the app status: Approved' do

  end
end