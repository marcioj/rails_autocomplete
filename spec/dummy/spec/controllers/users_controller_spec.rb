require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET autocomplete_name" do
    let(:term) { "" }
    let!(:user_1) { create(:user, name: "marcio") }
    let!(:user_2) { create(:user, name: "rodrigues") }
    let!(:user_3) { create(:user, name: "correa") }
    let!(:user_4) { create(:user, name: "marcio junior") }

    def action
      get :autocomplete_name, term: term, format: :json
    end

    context "simple search" do
      let(:term) { "mar" }
      before { action }

      it { expect(json_response.map { |r| r["id"] }).to match_array([user_1.id, user_4.id]) }
      it { expect(json_response.map { |r| r["label"] }).to match_array(["marcio", "marcio junior"]) }
      it { expect(json_response.map { |r| r["value"] }).to match_array(["marcio", "marcio junior"]) }
    end
  end
end
