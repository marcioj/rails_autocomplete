module ActionView
  module Helpers
    module FormTagHelper
      def autocomplete_tag(field, options = {})
        options[:data] = {}
        options[:data][:autocomplete] = true
        options[:data][:"autocomplete-url"] = url_for(action: "autocomplete_#{field}")
        text_field_tag(field, nil, options)
      end
    end

    module FormHelper
      def autocomplete()

      end
    end
  end
end
