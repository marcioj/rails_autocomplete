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
        options[:field] = field
        self.autocomplete_fields ||= {}
        self.autocomplete_fields[model_name.to_sym] = options

        define_method "autocomplete_#{field}" do
          model_class = model_name.classify.constantize
          relation = model_class.where("lower(#{field}) LIKE ?", "#{params[:term]}%").select(:id, field)
          attributes = relation.to_a.map(&:attributes)
          attributes.each do |attribute|
            attribute["value"] = attribute.delete(field.to_s)
            attribute["label"] = attribute["value"]
          end
          render json: attributes
        end
      end
    end
  end
end
