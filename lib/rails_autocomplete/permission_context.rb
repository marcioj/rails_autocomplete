require 'set'

module RailsAutocomplete
  class PermissionContext
    def initialize
      @model_class_and_allowed_fields = Hash.new {|h,k| h[k] = Set.new }
    end

    def allow_fields_for(model_class, field)
      @model_class_and_allowed_fields[model_class] << field.to_sym
    end

    def allowed_fields_for(model_class)
      @model_class_and_allowed_fields[model_class].to_a
    end
  end
end
