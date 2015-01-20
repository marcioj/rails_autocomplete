module RailsAutocomplete
  class DSL
    attr_reader :mapping

    def initialize(&block)
      @mapping = Mapping.new
      instance_eval(&block) if block
    end

    def field(name, options = {})
      options.assert_valid_keys(:from, :search_type)
      model_class = options.delete(:from)
      model_class = model_class.constantize rescue false if model_class.is_a?(String)
      raise "You should pass a valid ActiveRecord subclass to :from option"  unless model_class && model_class < ActiveRecord::Base
      raise "Unknow column #{name} for model #{model_class}" unless model_class.column_names.include?(name.to_s)
      @mapping.store_options_for(model_class, name, options)
    end
  end
end
