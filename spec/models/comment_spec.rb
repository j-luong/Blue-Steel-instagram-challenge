require "rails_helper"

describe Comment, type: :model do
  it 'is not valid with no comment' do
    comment = Comment.new(message: "")
    expect(comment).to have(2).error_on(:message)
    expect(comment).not_to be_valid
  end
end
