require 'rails_helper'

RSpec.describe Friendship, type: :model do
  fixtures :users, :posts
  let(:user_1){users(:michael)}
  let(:user_2){users(:juan)}

  describe 'validation' do
    context "when a user tries to do a legit request" do
      it 'should be valid' do
        relation = Friendship.new(user_id: user_2.id, friend_id: user_1.id)
        expect(relation.valid?).to be_truthy
      end
    end
    context "when some user is not present" do
      it 'should be invalid if there is not a sender' do
        relation = Friendship.new(user_id: user_2.id)
        expect(relation.valid?).to be_falsey
      end
      it 'should be invalid if there is not a receiver' do
        relation = Friendship.new(friend_id: user_1.id)
        expect(relation.valid?).to be_falsey
      end
      it 'should be invalid if there are not any participants' do
        relation = Friendship.new
        expect(relation.valid?).to be_falsey
      end
    end
    
    context 'when already exists the same relatioship' do
      it 'should be invalid' do
        user_1.requested_users << user_2
        relation = Friendship.new(user_id: user_2.id, friend_id: user_1.id)
        expect(relation.valid?).to be_falsey
      end
    end
    context 'when already exists the same combination of user-friend' do
      it 'should be invalid' do
        user_1.requested_users << user_2
        relation = Friendship.new(user_id: user_1.id, friend_id: user_2.id)
        expect(relation.valid?).to be_falsey
      end
    end
    context 'when an user tries to send a request to himself' do
      it 'should be invalid' do
        relation = Friendship.new(user_id: user_1.id, friend_id: user_1.id)
        expect(relation.valid?).to be_falsey
      end
    end
  end


end
