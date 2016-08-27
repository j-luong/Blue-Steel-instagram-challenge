require 'rails_helper'

feature 'commenting' do
  # before { Picture.create caption: 'KFC' }

  scenario 'allows users to leave a comment using a form' do
    pic = Picture.create caption: 'Blue Steel'
    visit "/pictures/#{pic.id}"
    click_link 'Comment'
    fill_in "Message", with: "BLUE STEEL!"
    click_button 'Leave Comment'

    expect(current_path).to eq "/pictures/#{pic.id}"
    expect(page).to have_content("BLUE STEEL!")
  end

end
