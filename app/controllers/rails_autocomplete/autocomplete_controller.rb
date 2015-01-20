module RailsAutocomplete
  class AutocompleteController < ApplicationController
    def index
      model_class = params[:model_class].constantize
      field = params[:field]
      options = RailsAutocomplete.mapping.retrieve_option_for(model_class, field)
      relation = RailsAutocomplete::Query.new(model_class, options).search(params[:term])
      attributes = relation.to_a.map(&:attributes)
      attributes.each do |attribute|
        attribute["value"] = attribute.delete(field.to_s)
        attribute["label"] = attribute["value"]
      end
      render json: attributes
    end
  end
end
