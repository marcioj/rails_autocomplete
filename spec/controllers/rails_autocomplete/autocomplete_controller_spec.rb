require 'spec_helper'

RSpec.describe RailsAutocomplete::AutocompleteController, type: :controller do
  routes { RailsAutocomplete::Engine.routes }

  before(:each) do
    RailsAutocomplete.permission_context = RailsAutocomplete::PermissionContext.new
  end

  def allow_fields_for(model_class, field)
    RailsAutocomplete.permission_context.allow_fields_for(model_class, field)
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
        allow_fields_for(User, :name)
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
        allow_fields_for(User, :address)
      end

      def action
        get :index, term: term, model_class: "User", field: "address", search_type: :ends_with, format: :json
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

    context "forbidden fields" do
      def action
        get :index, term: term, model_class: "User", field: "address", format: :json
      end

      before { action }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(json_response).to be_blank }
    end
  end
end
