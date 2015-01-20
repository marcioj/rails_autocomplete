require 'spec_helper'

RSpec.describe "autocomplete helpers", type: :view do
  before(:each) do
    RailsAutocomplete.permission_context = RailsAutocomplete::PermissionContext.new
  end

  def permission_context
    RailsAutocomplete.permission_context
  end

  describe "autocomplete_field_tag" do
    it "accepts an existing model field" do
      expect do
        view.autocomplete_field_tag(:name, from: "User")
      end.to_not raise_error
    end

    it "raises error when using a non existing model field" do
      expect do
        view.autocomplete_field_tag(:foo, from: "User")
      end.to raise_error("Unknow column foo for model User")
    end

    it "raises error when using a non existing option" do
      expect do
        view.autocomplete_field_tag(:foo, unknow_option: true)
      end.to raise_error("Unknown key: :unknow_option. Valid keys are: :from, :search_type")
    end

    it "raises error when not passing required options" do
      expect do
        view.autocomplete_field_tag(:name)
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end

    it "raises error when passing an inexistent class" do
      expect do
        view.autocomplete_field_tag(:name, from: "NotExist")
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end

    it "raises error when the provided class isn't a ActiveRecord subclass" do
      expect do
        view.autocomplete_field_tag(:name, from: String)
      end.to raise_error("You should pass a valid ActiveRecord subclass to :from option")
    end

    it "sets the allowed fields" do
      view.autocomplete_field_tag(:address, from: "User", search_type: :starts_with)
      view.autocomplete_field_tag(:name, from: "User", search_type: :starts_with)
      allowed_fields = permission_context.allowed_fields_for(User)
      expect(allowed_fields).to match_array([:address, :name])
    end
  end
end
