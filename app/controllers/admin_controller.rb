class AdminController < ApplicationController
  def shelter_index
    @shelters = Shelter.all
  end
end