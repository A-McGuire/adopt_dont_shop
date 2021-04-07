class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_application(pet, application)
    # self.where(pet_id: pet.id, application_id: application.id)
    # self.where(pet: pet, application: application)
    self.find_by(pet: pet, application: application)
  end
end