require 'rails_helper'

RSpec.describe "the Applications show page" do
  it "should display all application info" do

    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "pending", description: "I am good with dogs")

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    PetApplication.create!(pet: pet1, application: application1)
    PetApplication.create!(pet: pet2, application: application1)
    PetApplication.create!(pet: pet3, application: application1)
    
    visit "/applications/#{application1.id}"
    
    expect(page).to have_content(application1.name)
    expect(page).to have_content(application1.street_address)
    expect(page).to have_content(application1.city)
    expect(page).to have_content(application1.state)
    expect(page).to have_content(application1.zip_code)
    expect(page).to have_content(application1.status)
    expect(page).to have_content(application1.description)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet3.name)
  end
  
  it "should have a link to each pets show page. the link is the pets name" do 
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "pending", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    PetApplication.create!(pet: pet1, application: application1)
    PetApplication.create!(pet: pet2, application: application1)
    PetApplication.create!(pet: pet3, application: application1)
    
    visit "/applications/#{application1.id}"

    expect(page).to have_link("#{pet1.name}")
    expect(page).to have_link("#{pet2.name}")
    expect(page).to have_link("#{pet3.name}")

    click_link "#{pet1.name}"
    expect(current_path).to eq("/applications/#{application1.id}/pets/#{pet1.id}")
  end

  it "has a section to search for a pet by name, when you click submit the show page displays any pet whose name matches the search" do 
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    PetApplication.create!(pet: pet1, application: application1)
    PetApplication.create!(pet: pet2, application: application1)
    PetApplication.create!(pet: pet3, application: application1)

    visit "/applications/#{application1.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")

    fill_in "Search", with: "#{pet1.name}"
    click_button "Search"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("#{pet1.name}")
  end

  it "only displays pet search bar if the application status is 'In Progress'" do
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "Pending", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    visit "/applications/#{application1.id}"

    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to_not have_button("Search")
  end

  it 'allows me to add a pet to my application' do
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    visit "/applications/#{application1.id}"

    fill_in "Search", with: "#{pet1.name}"
    click_button "Search"
    
    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("#{pet1.name}")
    
    expect(page).to have_button("Adopt this Pet")
    click_button "Adopt this Pet"
    expect(page).to have_content("#{pet1.name}")
    
    fill_in "Search", with: "#{pet2.name}"
    click_button "Search"
    
    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("#{pet2.name}")
    
    expect(page).to have_button("Adopt this Pet")
    click_button "Adopt this Pet"

    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_content("#{pet2.name}")
  end

  it 'can submit an application after I have added one or more pets the to application' do
    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter.id)
    
    visit "/applications/#{application1.id}"

    fill_in "Search", with: "#{pet1.name}"
    click_button "Search"
    expect(page).to have_content("#{pet1.name}")
    click_button "Adopt this Pet"
    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_button("Submit Application")
    
    fill_in "Search", with: "#{pet2.name}"
    click_button "Search"
    expect(page).to have_content("#{pet2.name}")
    click_button "Adopt this Pet"
    expect(page).to have_content("#{pet2.name}")
    
    expect(page).to have_button("Submit Application")
    
    click_button "Submit Application"
    
    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("Application Status: Pending")
    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_content("#{pet2.name}")
    
    expect(page).to_not have_button("Adopt this Pet")
    expect(page).to_not have_button("Submit Application")
    expect(page).to_not have_button("Search")
  end
end
