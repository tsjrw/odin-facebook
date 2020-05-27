require 'rails_helper'

RSpec.describe Comment, type: :model do
  fixtures :users


  let(:user){ users(:michael) }
  let(:comment){ user.comments.build(content: "", post_id: user.posts.first.id) }

  describe "content" do
    it "should be present" do
      expect(comment.valid?).to be_falsey
      comment.content = "a"
      expect(comment.valid?).to be_truthy
    end
    it "should have equal or less than 140 characters" do
      comment.content = "a"*140
      expect(comment.valid?).to be_truthy
      comment.content = "a"*141
      expect(comment.valid?).to be_falsey
    end
  end
end
