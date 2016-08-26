require 'rails_helper'

feature 'pictures' do
  context 'no pictures have been added' do
    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link 'Add a picture'
    end
  end

  context 'pictures have been added' do
    before do
      Picture.create(caption: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/pictures'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating pictures' do
    scenario 'prompts user to fill out a form, then displays the new picture' do
      visit '/pictures'
      click_link 'Add a picture'
      fill_in 'Caption', with: 'KFC'
      click_button 'Create Picture'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/pictures'
    end
  end

  context 'viewing pictures' do

  let!(:kfc){ Picture.create(caption:'KFC') }

  scenario 'lets a user view a picture' do
   visit '/pictures'
   click_link 'KFC'
   expect(page).to have_content 'KFC'
   expect(current_path).to eq "/pictures/#{kfc.id}"
  end

end
end