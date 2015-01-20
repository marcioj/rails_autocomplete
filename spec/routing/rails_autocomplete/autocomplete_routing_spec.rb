require 'spec_helper'

RSpec.describe RailsAutocomplete::AutocompleteController, type: :routing do
  routes { RailsAutocomplete::Engine.routes }

  describe 'routing' do
    it { expect(get('autocomplete')).to route_to('rails_autocomplete/autocomplete#index') }
  end

  describe 'route helpers' do
    it { expect(autocomplete_path).to eq('/rails_autocomplete/autocomplete') }
  end
end
