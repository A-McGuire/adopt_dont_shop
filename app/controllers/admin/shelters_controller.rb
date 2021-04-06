class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_desc
    @has_pending = Shelter.with_pending_applications
  end
end