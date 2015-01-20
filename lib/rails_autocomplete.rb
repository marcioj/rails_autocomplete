require "rails_autocomplete/engine"
require "rails_autocomplete/helpers"
require "rails_autocomplete/query"
require "rails_autocomplete/permission_context"

module RailsAutocomplete
  extend self

  attr_accessor :mapping
  attr_accessor :permission_context

  def autocomplete(&block)
    self.mapping = DSL.new(&block).mapping
  end
end
