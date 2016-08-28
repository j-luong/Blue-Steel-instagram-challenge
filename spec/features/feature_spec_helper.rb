def sign_up(email: "test@example.com", password: "testtest")
  visit("/")
  click_link("Sign up")
  fill_in("Email", with: email)
  fill_in("Password", with: password)
  fill_in("Password confirmation", with: password)
  click_button("Sign up")
end

def sign_in(email:, password:)
  visit("/")
  click_link("Sign in")
  fill_in("Email", with: email)
  fill_in("Password", with: password)
  click_button("Log in")
end

def add_picture(caption: "BLUE STEEL")
  visit("/pictures")
  click_link("Add a picture")
  fill_in("Caption", with: caption)
  click_button("Create Picture")
end

def leave_comment(picture, message: "AMAZING")
  visit("/pictures/#{picture.id}")
  click_link "Comment"
  fill_in "Message", with: message
  click_button "Leave Comment"
end
