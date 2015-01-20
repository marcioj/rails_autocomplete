module RailsAutocomplete
  class AutocompleteController < ApplicationController
    def index
      model_class = params[:model_class].constantize
      field = params[:field].to_sym
      if permission_context.allowed_fields_for(model_class).include?(field)
        relation = RailsAutocomplete::Query.new(model_class, params).search(params[:term])
        attributes = relation.to_a.map(&:attributes)
        attributes.each do |attribute|
          attribute["value"] = attribute.delete(field.to_s)
          attribute["label"] = attribute["value"]
        end
        render json: attributes
      else
        render json: {}, status: :unauthorized
      end
    end

    protected
      def permission_context
        RailsAutocomplete.permission_context
      end
  end
end
