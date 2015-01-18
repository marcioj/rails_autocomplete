module RailsAutocomplete
  class Router
    def initialize(mapper)
      @mapper = mapper
      require_controllers
      generate_routes
    end

    def generate_routes
      ApplicationController.subclasses.map(&:autocomplete_fields).compact.each do |autocomplete_fields|
        autocomplete_fields.each do |model_name, field_options|
          field_options.each do |field, options|
            controller_name = options[:controller_name]
            field = options[:field]
            resource = options[:controller_name].gsub(/_controller$/, "")
            @mapper.get "#{resource}/autocomplete_#{field}" => controller_name
          end
        end
      end
    end

    def require_controllers
      # TODO I think this can slow down great apps
      Dir[Rails.root.join("app", "controllers", "**", "*_controller.rb")].each do |controller_file|
        require(controller_file)
      end
    end
  end

  class << self
    def routes(mapper)
      Router.new(mapper)
    end
  end
end
