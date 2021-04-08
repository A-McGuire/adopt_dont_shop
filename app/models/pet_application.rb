class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_application(pet, application)
    self.find_by(pet: pet, application: application)
  end
end