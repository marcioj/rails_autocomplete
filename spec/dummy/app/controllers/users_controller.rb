class UsersController < ApplicationController
  autocomplete :name
  autocomplete :address, search_type: :ends_with

  def index
  end
end
