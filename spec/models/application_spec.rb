require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:pets).through(:pet_applications)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    it 'finds the correct pet_application for the specific application and pet pair' do
      application = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
    
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet2 = Pet.create!(adoptable: true, age: 5, breed: 'shiba', name: 'Spinach', shelter_id: shelter.id)
      pet_app_1 = PetApplication.create!(pet: pet1, application: application)
      pet_app_2 = PetApplication.create!(pet: pet2, application: application)

      expect(application.find_pet_application(pet1)).to eq(pet_app_1)
      expect(application.find_pet_application(pet2)).to eq(pet_app_2)
    end
  end
end