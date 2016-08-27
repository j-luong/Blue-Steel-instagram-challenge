require "rails_helper"

describe Picture, type: :model do
  it 'is not valid with a name of less than three characters' do
    picture = Picture.new(caption: "kf")
    expect(picture).to have(1).error_on(:caption)
    expect(picture).not_to be_valid
  end
end
