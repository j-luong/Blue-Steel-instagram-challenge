require "rails_helper"

feature "pictures" do
  context "no pictures have been added" do
    scenario "should display a prompt to add a picture" do
      sign_up
      expect(page).to have_content "No pictures yet"
      expect(page).to have_link "Add a picture"
    end
  end

  context "pictures have been added" do
    scenario "display picutres" do
      sign_up
      add_picture
      expect(page).to have_content("BLUE STEEL")
      expect(page).not_to have_content("No pictures yet")
    end
  end

  context "creating pictures" do
    scenario "prompts user to fill out a form, then displays the new picture" do
      sign_up
      add_picture
      expect(page).to have_content "BLUE STEEL"
      expect(current_path).to eq "/pictures"
    end

    context "an invalid picture" do
      it "does not let you submit a name that is too short" do
        sign_up
        add_picture(caption: "bs")
        expect(page).not_to have_css "h2", text: "bs"
        expect(page).to have_content "error"
      end
    end
  end

  context "viewing pictures" do
    scenario "lets a user view a picture" do
      user = User.create(email: "test@test.com", password: "password")
      pic = Picture.create(caption: "FERRARI", user_id: user.id)
      visit "/pictures"
      click_link "FERRARI"
      expect(page).to have_content "FERRARI"
      expect(current_path).to eq "/pictures/#{pic.id}"
    end
  end

  context "editing pictures" do
    scenario "let a user edit a picture" do
      user = User.create(email: "test@test.com", password: "password")
      Picture.create(caption: "FERRARI", user_id: user.id)
      sign_in(email: user.email, password: user.password)

      click_link "Edit picture"
      fill_in "Caption", with: "LE TIGRE"
      click_button "Update Picture"
      expect(page).to have_content "LE TIGRE"
      expect(current_path).to eq "/pictures"
    end
  end

  context "deleting pictures" do
    scenario "removes a picture when a user clicks a delete link" do
      user = User.create(email: "test@test.com", password: "password")
      Picture.create(caption: "FERRARI", user_id: user.id)
      sign_in(email: user.email, password: user.password)

      click_link "Delete picture"
      expect(page).not_to have_content "FERRARI"
      expect(page).to have_content "Picture deleted successfully"
    end
  end
end
