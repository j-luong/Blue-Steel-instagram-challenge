require 'rails_helper'

feature 'commenting' do
  # before { Picture.create caption: 'KFC' }

  scenario 'allows users to leave a comment using a form' do
    pic = Picture.create caption: 'CFK'
    visit "/pictures/#{pic.id}"
    click_link 'Comment'
    fill_in "Message", with: "so so"
    click_button 'Leave Comment'

    expect(current_path).to eq "/pictures/#{pic.id}"
    expect(page).to have_content('so so')
  end

end
