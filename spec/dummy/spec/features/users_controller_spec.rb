require 'spec_helper'

RSpec.describe UsersController, type: :feature do
  let!(:user_2) { create(:user, name: "marcio") }
  let!(:user_2) { create(:user, name: "marcio junior") }
  let!(:user_3) { create(:user, name: "yo") }

  def choose_autocomplete(text)
    expect(find('ul.ui-autocomplete')).to have_content(text)
    page.execute_script("$('.ui-menu-item:contains(\"#{text}\")').trigger('mouseenter').click()")
  end

  def fill_in_autocomplete(id, value)
    fill_in id, with: value
    page.execute_script "$('##{id}').keydown()"
  end

  it "works", js: true do
    visit '/users'
    fill_in_autocomplete 'name', 'marc'
    choose_autocomplete 'marcio junior'
    expect(page).to have_field('name', with: 'marcio junior')
  end
end
