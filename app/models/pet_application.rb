class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_application(pet, application)
    binding.pry
  end
end