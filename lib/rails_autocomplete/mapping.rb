module RailsAutocomplete
  class Mapping
    def initialize
      @data = Hash.new {|h,k| h[k] = Hash.new(&h.default_proc) }
    end

    def store_options_for(model_class, field, options)
      opt = options.dup
      field = field.to_sym
      opt[:model_class] = model_class
      opt[:field] = field
      @data[model_class][field] = opt
    end

    def retrieve_option_for(model_class, field)
      @data[model_class][field.to_sym]
    end
  end
end
