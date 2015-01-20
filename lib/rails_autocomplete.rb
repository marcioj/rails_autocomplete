require "rails_autocomplete/engine"
require "rails_autocomplete/helpers"
require "rails_autocomplete/query"
require "rails_autocomplete/dsl"
require "rails_autocomplete/mapping"

module RailsAutocomplete
  extend self

  attr_accessor :mapping

  def autocomplete(&block)
    self.mapping = DSL.new(&block).mapping
  end
end
