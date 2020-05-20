require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  let(:user){ users(:michael) }

  context "creating an user" do
    it "should save an user with valid attributes" do
      expect(user.valid?).to be_truthy
      expect(user.save).to be_truthy
    end
    it "should not save an user with a invalid name" do
      user.name = ""
      expect(user.valid?).to be_falsey
      user.name = "a"
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey
    end
  end
  
end
