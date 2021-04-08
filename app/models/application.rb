class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  
  validates :name, :street_address, :city, :state, :description, :status, presence: true
  validates :zip_code, presence: true, numericality: true

  def find_pet_application(pet)
    self.pet_applications.find_by(pet: pet)
  end
end

 #  def self.find_pet_application(pet, application)
  #   self.find_by(pet: pet, application: application)
  # end