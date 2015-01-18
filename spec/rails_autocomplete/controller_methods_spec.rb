require 'spec_helper'

RSpec.describe RailsAutocomplete::ControllerMethods do
  describe "exists" do
    it { expect(RailsAutocomplete::ControllerMethods).to be_present }
  end

  describe "#autocomplete" do
    context "field param" do
      it "accepts a existing model field" do
        expect do
          UsersController.instance_eval do
            autocomplete :name
          end
        end.to_not raise_error
      end

      it "raises error when using a non existing model field" do
        expect do
          UsersController.instance_eval do
            autocomplete :foo
          end
        end.to raise_error("Unknow column foo for model User")
      end
    end

    context "options" do
      it "raises error when using a non existing option" do
        expect do
          UsersController.instance_eval do
            autocomplete :name, unknow_option: true
          end
        end.to raise_error("Unknown key: :unknow_option. Valid keys are: :search_type")
      end
    end
  end
end
