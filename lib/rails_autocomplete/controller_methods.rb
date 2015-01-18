module RailsAutocomplete
  module ControllerMethods
    extend ActiveSupport::Concern

    included do
      class_attribute :autocomplete_fields
      self.autocomplete_fields = Hash.new {|h,k| h[k] = Hash.new(&h.default_proc) }
    end

    module ClassMethods
      def autocomplete(field, options = {})
        options.assert_valid_keys(:search_type)
        model_name = controller_name.gsub(/_controller$/, "").singularize
        model_class = model_name.classify.constantize
        raise "Unknow column #{field} for model #{model_class}" unless model_class.column_names.include?(field.to_s)
        options[:controller_name] = controller_name
        options[:field] = field
        self.autocomplete_fields[model_name.to_sym][field] = options

        define_method "autocomplete_#{field}" do
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
  end
end
