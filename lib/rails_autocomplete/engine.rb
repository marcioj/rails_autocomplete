module RailsAutocomplete
  class Engine < ::Rails::Engine
    isolate_namespace RailsAutocomplete

    initializer "rails_autocomplete.initialize_permission_context" do
      RailsAutocomplete.permission_context = RailsAutocomplete::PermissionContext.new
    end
  end
end
