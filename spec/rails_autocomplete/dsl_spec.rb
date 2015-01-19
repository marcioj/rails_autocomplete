require 'spec_helper'

RSpec.describe RailsAutocomplete::ControllerMethods do
  describe "exists" do
    it { expect(RailsAutocomplete::DSL).to be_present }
  end

  describe "#field" do
    it "accepts a existing model field" do
      expect do
        RailsAutocomplete::DSL.new do
          field :name, from: "User"
        end
      end.to_not raise_error
    end

    it "raises error when using a non existing model field" do
      expect do
        RailsAutocomplete::DSL.new do
          field :foo, from: "User"
        end
      end.to raise_error("Unknow column foo for model User")
    end

    it "raises error when using a non existing option" do
      expect do
        RailsAutocomplete::DSL.new do
          field :foo, unknow_option: true
        end
      end.to raise_error("Unknown key: :unknow_option. Valid keys are: :from, :search_type")
    end

    it "raises error when not passing required options" do
      expect do
        RailsAutocomplete::DSL.new do
          field :name
        end
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end

    it "raises error when passing an inexistent class" do
      expect do
        RailsAutocomplete::DSL.new do
          field :name, from: "NotExist"
        end
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end

    it "raises error when the provided class isn't a ActiveRecord subclass" do
      expect do
        RailsAutocomplete::DSL.new do
          field :name, from: String
        end
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end
  end
end
