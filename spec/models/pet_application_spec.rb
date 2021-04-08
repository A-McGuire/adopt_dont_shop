require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "class methods" do
    # describe "#find_pet_application(pet, application)" do
    #   it 'returns the correct pet_application' do 
    #     application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
      
    #     shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    #     pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    #     pet2 = Pet.create!(adoptable: true, age: 5, breed: 'shiba', name: 'Spinach', shelter_id: shelter.id)
    #     pet_app_1 = PetApplication.create!(pet: pet1, application: application)
    #     pet_app_2 = PetApplication.create!(pet: pet2, application: application)
        
    #     expect(PetApplication.find_pet_application(pet1, application)).to eq(pet_app_1)
    #     expect(PetApplication.find_pet_application(pet2, application)).to eq(pet_app_2)
    #   end
    # end
  end
end
