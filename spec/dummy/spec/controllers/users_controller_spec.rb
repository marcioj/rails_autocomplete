require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET autocomplete_user" do
    let!(:user_1) { create(:user, name: "foo") }
    let!(:user_2) { create(:user, name: "bar") }
    let!(:user_3) { create(:user, name: "yo") }

    def action
      get :autocomplete_user, format: :json
    end

    before { action }

    it { expect(json_response.map { |r| r["name"] }).to match_array(["foo", "bar", "yo"]) }
  end
end
