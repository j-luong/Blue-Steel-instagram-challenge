require 'rails_helper'

feature 'commenting' do
  context 'adding comments' do
    it 'allows users to leave a comment using a form' do
      pic = Picture.create caption: 'Blue Steel'
      visit "/pictures/#{pic.id}"
      click_link 'Comment'
      fill_in "Message", with: "BLUE STEEL!"
      click_button 'Leave Comment'

      expect(current_path).to eq "/pictures/#{pic.id}"
      expect(page).to have_content("BLUE STEEL!")
    end
  end

  context 'message is too short' do
    it 'does not let you submit a message that is too short' do
      pic = Picture.create caption: 'Blue Steel'
      visit "/pictures/#{pic.id}"
      click_link 'Comment'
      click_button 'Leave Comment'
      expect(page).to have_content 'error'
    end
  end
end
