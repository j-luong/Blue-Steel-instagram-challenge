require "rails_helper"

feature "liking pictures" do
  scenario "a user can like a picture, which updates the likes count", js: true do
    user = User.create(email: "test@test.com", password: "password")
    pic = Picture.create(caption: "FERRARI", user_id: user.id)
    sign_in(email: user.email, password: user.password)
    visit "/pictures/#{pic.id}"
    click_link "Like"
    expect(page).to have_content("1 like")
  end
end
