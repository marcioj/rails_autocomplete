require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET autocomplete_name" do
    let(:term) { "" }

    context "simple search" do
      def action
        get :autocomplete_name, term: term, format: :json
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
      def action
        get :autocomplete_address, term: term, format: :json
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
