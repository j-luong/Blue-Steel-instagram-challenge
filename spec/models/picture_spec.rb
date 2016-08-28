require "rails_helper"

describe Picture, type: :model do
  it 'is not valid with a name of less than three characters' do
    picture = Picture.new(caption: "bs")
    expect(picture).to have(1).error_on(:caption)
    expect(picture).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: "test@test.com", password: "password")
    Picture.create(caption: "Magnum", user_id: user.id)
    restaurant = Picture.new(caption: "Magnum")
    expect(restaurant).to have(1).error_on(:caption)
  end
end
