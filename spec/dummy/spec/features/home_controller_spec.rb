require 'spec_helper'

RSpec.describe HomeController, type: :feature do
  it "works" do
    visit '/'
    expect(page).to have_content 'Hello world'
  end
end
