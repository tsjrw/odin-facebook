require 'rails_helper'

RSpec.describe Post, type: :model do

  fixtures :users

  let(:user){ users(:michael) }
  let(:post){ user.posts.build(content: "content") }
  
  describe "content" do
    it "should be present" do
      post.content = ""
      expect(post.valid?).to be_falsey
      post.content = "a"
      expect(post.valid?).to be_truthy
    end
    it "should have equal or less than 1000 characters" do
      post.content = "a"*1000
      expect(post.valid?).to be_truthy
      post.content = "a"*1001
      expect(post.valid?).to be_falsey
    end
  end


end
