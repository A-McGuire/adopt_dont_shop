require 'rails_helper'

RSpec.describe "the Applications index page" do
  it "should display all applications" do

    application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "pending", description: "I am good with dogs")
    application2 = Application.create!(name: "app2", street_address: "456 street", city: "Brooklyn", state: "NY", zip_code: 11111, status: "accepted", description: "I am great with dogs!")

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    
    PetApplication.create!(pet: pet1, application: application1)
    PetApplication.create!(pet: pet2, application: application2)
    

    visit '/playlists'

    expect(page).to have_content(application1.name)
    expect(page).to have_content(application1.street_address)
    expect(page).to have_content(application1.city)
    expect(page).to have_content(application1.state)
    expect(page).to have_content(application1.zip_code)
    expect(page).to have_content(application1.status)
    expect(page).to have_content(application1.description)

    # within("#playlist-#{rock.id}") do
    #   expect(page).to have_content(rock.name)
    #   expect(page).to have_content(place.title)
    #   expect(page).to have_content(breadbox.title)
    #   expect(page).to have_content(r_and_c.title)
    # end

    # within("#playlist-#{uplifting_sound.id}") do
    #   expect(page).to have_content(uplifting_sound.name)
    #   expect(page).to have_content(purple.title)
    # end

    # within("#playlist-#{jams.id}") do
    #   expect(page).to have_content(jams.name)
    #   expect(page).to have_content(purple.title)
    #   expect(page).to have_content(place.title)
    # end
  end
end
