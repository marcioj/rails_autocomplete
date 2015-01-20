require 'spec_helper'

RSpec.describe RailsAutocomplete::AutocompleteController, type: :controller do
  routes { RailsAutocomplete::Engine.routes }

  after(:each) do
    RailsAutocomplete.mapping = nil
  end

  def json_response
    JSON.parse(response.body)
  end

  describe "exists" do
    it { expect(RailsAutocomplete::AutocompleteController).to be_present }
  end

  describe "GET index" do
    let(:term) { "" }

    context "simple search" do
      before do
        RailsAutocomplete.autocomplete do
          field :name, from: "User"
        end
      end

      def action
        get :index, term: term, model_class: "User", field: "name", format: :json
      end

      let!(:user_1) { create(:user, name: "marcio") }
      let!(:user_2) { create(:user, name: "foo") }
      let!(:user_3) { create(:user, name: "marcio junior") }
      let(:term) { "mar" }
      before { action }

      it { expect(json_response.map { |r| r["id"] }).to match_array([user_1.id, user_3.id]) }
      it { expect(json_response.map { |r| r["label"] }).to match_array(["marcio", "marcio junior"]) }
      it { expect(json_response.map { |r| r["value"] }).to match_array(["marcio", "marcio junior"]) }
    end

    context "with search type ends_with" do
      before do
        RailsAutocomplete.autocomplete do
          field :address, from: "User", search_type: :ends_with
        end
      end

      def action
        get :index, term: term, model_class: "User", field: "address", format: :json
      end

      let!(:user_1) { create(:user, address: "whatever street") }
      let!(:user_2) { create(:user, address: "awesome whatever street") }
      let!(:user_3) { create(:user, address: "foo avenue") }
      let(:term) { "street" }
      before { action }

      it { expect(json_response.map { |r| r["id"] }).to match_array([user_1.id, user_2.id]) }
      it { expect(json_response.map { |r| r["label"] }).to match_array(["whatever street", "awesome whatever street"]) }
      it { expect(json_response.map { |r| r["value"] }).to match_array(["whatever street", "awesome whatever street"]) }
    end
  end
end
