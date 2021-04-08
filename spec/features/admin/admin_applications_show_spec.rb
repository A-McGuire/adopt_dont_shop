require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve the adoption each individual pet for that application' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    
    application.pets << pet1

    visit "/admin/applications/#{application.id}"
    
    within("pet-#{pet1.id}") do 
      expect(page).to have_button("Approve")
      click_button("Approve")
      expect(page).to have_content("Application Status: Approved")
    end
  end

  it 'has a button to reject the adoption each individual pet for that application' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    
    application.pets << pet1

    visit "/admin/applications/#{application.id}"
    
    expect(page).to have_button("Reject")

    click_button("Reject")
    # save_and_open_page
    expect(page).to have_content("Application Status: Rejected")
  end
  
  # it 'it does not approve all pets on the app, only the one selected' do
  #   application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
  #   shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  #   pet2 = Pet.create!(adoptable: true, age: 2, breed: 'collie', name: 'fido', shelter_id: shelter.id)
  #   pet3 = Pet.create!(adoptable: true, age: 3, breed: 'lab', name: 'max', shelter_id: shelter.id)
    
  #   application.pets.push(pet1, pet2, pet3)
  
  #   visit "/admin/applications/#{application.id}"
  #   expect(page).to have_button("Approve")
  
  #   click_button("Approve")
  #   # save_and_open_page
  #   expect(page).to have_content("Application Status: Approved")

  # end
end