require 'rails_helper'

RSpec.describe "Friendships", type: :request do
    fixtures :users, :posts
    let(:user_1){users(:michael)}
    let(:user_2){users(:juan)}
    let(:referrer){ {'HTTP_REFERER' => "#{user_path(user_2)}"} }

    def send_request
        sign_in user_1
        post user_friendships_path(user_2.id), headers: referrer
        sign_out user_2
    end

    def accept_request
        sign_in user_2
        put user_friendship_path(user_1.id), headers: referrer
        sign_out user_2 
    end

    describe 'send request' do
        context "when not logged" do
            it 'should redirect' do
                expect{ post user_friendships_path(user_2.id) }.to change(user_2.friend_requests, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context "when logged" do
            it 'should be sent successfully' do
                sign_in user_1
                expect{ post user_friendships_path(user_2.id), headers: referrer }.to change(user_2.friend_requests, :count).by(1)
            end
        end
    end

    describe "accept request" do
        context "when not logged" do
            it 'should redirect' do
                expect{ put user_friendship_path(user_2.id) }.to change(user_2.friend_requests, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context "when logged" do
            it 'should be accepted successfully' do
                send_request
                sign_in user_2
                expect(user_2.friends.count).to be(0)
                put user_friendship_path(user_1.id), headers: referrer
                expect(user_2.friends.count).to be(1)
            end
        end
    end

    describe "decline request / delete friend" do
        context "when not logged" do
            it 'should redirect' do
                expect{ delete user_friendship_path(user_2.id) }.to change(user_2.friend_requests, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context "when logged" do
            it 'should decline the request successfully' do
                send_request
                sign_in user_2
                expect{ delete user_friendship_path(user_1.id), headers: referrer }.to change(user_2.friend_requests, :count).by(-1)

            end
            it 'should destroy the friendship between two users' do
                send_request
                accept_request
                sign_in user_1
                expect{ delete user_friendship_path(user_2.id), headers: referrer }.to change(Friendship, :count).by(-1)

            end
        end
    end
    
end
