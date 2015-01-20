module RailsAutocomplete
  class Query
    def initialize(model_class, options = {})
      @model_class = model_class
      @options = options
    end

    def search(term)
      field = options[:field]
      search_type = (options[:search_type].presence || :starts_with).to_sym

      term = case search_type
        when :starts_with then "#{term}%"
        when :ends_with then "%#{term}"
        else raise "Unknow search type #{search_type}"
      end

      model_class.where("lower(#{field}) LIKE ?", term).select(:id, field)
    end

    private
      attr_reader :model_class, :options
  end
end
