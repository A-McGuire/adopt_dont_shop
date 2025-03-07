# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

application1 = Application.create!(name: "app1", street_address: "123 street", city: "Denver", state: "CO", zip_code: 80210, status: "In Progress", description: "I am good with dogs")
application2 = Application.create!(name: "app2", street_address: "456 street", city: "Brooklyn", state: "NY", zip_code: 11111, status: "In Progress", description: "I am great with dogs!!")
application3 = Application.create!(name: "app3", street_address: "789 street", city: "Wooville", state: "WY", zip_code: 11111, status: "In Progress", description: "I am great with dogs!!!")
application4 = Application.create!(name: "app4", street_address: "101 street", city: "Hooville", state: "TX", zip_code: 11111, status: "In Progress", description: "I am great with dogs!!!!")

shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 10)
shelter3 = Shelter.create(name: 'fancy shelter', city: 'fancy, CO', foster_program: false, rank: 10)
shelter4 = Shelter.create(name: 'ABC animal shelter', city: 'Harlingen, NM', foster_program: false, rank: 5)
shelter5 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter1.id)
pet2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter1.id)
pet3 = Pet.create!(adoptable: true, age: 4, breed: 'Shiba', name: 'Broccoli', shelter_id: shelter2.id)

application1.pets.push(pet1,pet2)
application2.pets.push(pet1,pet3)
application3.pets.push(pet1,pet3,pet2)
application4.pets.push(pet1)

@vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_1 = @vet_office.veterinarians.create(name: 'Taylor', review_rating: 10, on_call: true)
@vet_2 = @vet_office.veterinarians.create(name: 'Tanya', review_rating: 9, on_call: true)
@vet_3 = @vet_office.veterinarians.create(name: 'Jim', review_rating: 8, on_call: true)
