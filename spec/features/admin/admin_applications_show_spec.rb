require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve the adoption each individual pet for that application' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 1, breed: 'Good', name: 'Good Pup', shelter_id: shelter.id)
    
    application.pets << pet1
    application.pets << pet2

    visit "/admin/applications/#{application.id}"
    within("#pet-#{pet1.id}") do 
      expect(page).to have_button("Approve")
      click_button("Approve")
      expect(page).to have_content("Application Status: Approved")
    end
  end

  it 'has a button to reject the adoption each individual pet for that application' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 1, breed: 'good', name: 'Good pup', shelter_id: shelter.id)
    
    application.pets << pet1
    application.pets << pet2

    visit "/admin/applications/#{application.id}"

    within("#pet-#{pet1.id}") do 
      expect(page).to have_button("Reject")

      click_button("Reject")
      expect(page).to have_content("Application Status: Rejected")
    end
  end
  
  it 'it does not approve all pets on the app, only the one selected' do
    application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 2, breed: 'collie', name: 'fido', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 3, breed: 'lab', name: 'max', shelter_id: shelter.id)
    
    application.pets.push(pet1, pet2, pet3)
  
    visit "/admin/applications/#{application.id}"
    within("#pet-#{pet1.id}") do
      click_button("Approve")
      expect(page).to have_content("Application Status: Approved")
      expect(page).to_not have_button("Approve")
    end

    within("#pet-#{pet2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to_not have_content("Application Status: Approved")
    end

    within("#pet-#{pet3.id}") do
      expect(page).to have_button("Approve")
      expect(page).to_not have_content("Application Status: Approved")
    end
  end

  it 'does not approve all applications for a pet across all applications' do
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    application2 = Application.create!(name: "app2", street_address: "456 street", city: "Denver", state: "CO", zip_code: 80240, status: "In Progress", description: "I am v good with dogs")
  
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    
    application1.pets << pet1
    application2.pets << pet1

    visit "/admin/applications/#{application1.id}"

    within("#pet-#{pet1.id}") do
      click_button("Approve")
      expect(page).to have_content("Application Status: Approved")
      expect(page).to_not have_button("Approve")
    end

    visit "/admin/applications/#{application2.id}"
    
    within("#pet-#{pet1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to_not have_content("Application Status: Approved")
    end
  end
end