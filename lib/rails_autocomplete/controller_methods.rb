module RailsAutocomplete
  module ControllerMethods
    extend ActiveSupport::Concern

    included do
      class_attribute :autocomplete_fields
    end

    module ClassMethods
      def autocomplete(field, options = {})
        model_name = controller_name.gsub(/_controller$/, "").singularize
        options[:controller_name] = controller_name
        self.autocomplete_fields ||= {}
        self.autocomplete_fields[model_name.to_sym] = options

        define_method "autocomplete_#{model_name}" do
          model_class = model_name.classify.constantize
          render json: model_class.select(field)
        end
      end
    end
  end
end
