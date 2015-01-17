module RailsAutocomplete
  class Engine < ::Rails::Engine

    initializer "rails_autocomplete.controller_methods" do
      ActiveSupport.on_load(:action_controller) do
        include RailsAutocomplete::ControllerMethods
      end
    end

  end
end
