module ActionView
  module Helpers
    module FormTagHelper
      def autocomplete_field_tag(field_name, options = {})
        options.assert_valid_keys(:from, :search_type)
        model_class = options[:from]
        model_class = model_class.constantize rescue false if model_class.is_a?(String)
        raise "You should pass a valid ActiveRecord subclass to :from option"  unless model_class && model_class < ActiveRecord::Base
        raise "Unknow column #{field_name} for model #{model_class}" unless model_class.column_names.include?(field_name.to_s)
        RailsAutocomplete.permission_context.allow_fields_for(model_class, field_name)
        transform_to_html_options!(field_name, options)
        text_field_tag(field_name, nil, options)
      end

      private
        def transform_to_html_options!(field_name, options)
          options[:data] = {}
          options[:data][:autocomplete] = true
          options[:data][:"autocomplete-url"] = rails_autocomplete.autocomplete_path
          options[:data][:"autocomplete-model-class"] = options.delete(:from).to_s
          options[:data][:"autocomplete-field"] = field_name
          options[:data][:"autocomplete-search-type"] = options.delete(:search_type)
        end
    end

    module FormHelper
      def autocomplete()

      end
    end
  end
end
