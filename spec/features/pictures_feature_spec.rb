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
      Picture.create(caption: 'FERRARI')
    end

    scenario 'display restaurants' do
      visit '/pictures'
      expect(page).to have_content('FERRARI')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating pictures' do
    scenario 'prompts user to fill out a form, then displays the new picture' do
      visit '/pictures'
      click_link 'Add a picture'
      fill_in 'Caption', with: 'FERRARI'
      click_button 'Create Picture'
      expect(page).to have_content 'FERRARI'
      expect(current_path).to eq '/pictures'
    end

    context 'an invalid picture' do
      it 'does not let you submit a name that is too short' do
        visit '/pictures'
        click_link 'Add a picture'
        fill_in 'Caption', with: 'kf'
        click_button 'Create Picture'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing pictures' do
    let!(:kfc){ Picture.create(caption:'FERRARI') }

    scenario 'lets a user view a picture' do
      visit '/pictures'
      click_link 'FERRARI'
      expect(page).to have_content 'FERRARI'
      expect(current_path).to eq "/pictures/#{kfc.id}"
    end
  end

  context 'editing pictures' do
    before { Picture.create caption: 'FERRARI' }

    scenario 'let a user edit a picture' do
      visit '/pictures'
      click_link 'Edit picture'
      fill_in 'Caption', with: 'LE TIGRE'
      click_button 'Update Picture'
      expect(page).to have_content 'LE TIGRE'
      expect(current_path).to eq '/pictures'
    end
  end

  context 'deleting pictures' do
    before { Picture.create caption: 'FERRARI' }

    scenario 'removes a picture when a user clicks a delete link' do
      visit '/pictures'
      click_link 'Delete picture'
      expect(page).not_to have_content 'FERRARI'
      expect(page).to have_content 'Picture deleted successfully'
    end
  end
end
